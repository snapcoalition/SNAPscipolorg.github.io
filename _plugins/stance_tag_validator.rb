require "set"
require "date"

module StanceResponseValidator
  FILTERS_KEY = "stance_filters".freeze
  RESPONSES_KEY = "stance_responses".freeze
  QUESTIONS_KEY = "stance_questions".freeze

  RESPONSE_REQUIRED_FIELDS = %w[candidate_first_name candidate_last_name state race party question response].freeze
  QUESTION_REQUIRED_FIELDS = %w[id question tag].freeze
  COUNTY_RACE_RACE = "Local County Races [All]".freeze

  # `races` is the canonical list of allowed race values; `race_ballot_order` is
  # the same set reordered by ballot position for the "Group by candidate" view.
  # A race in only one list drifts silently — it either sorts to the end of the
  # explorer or sits in the config as a dead entry — so require exact agreement.
  def self.validate_filters(site)
    filters = site.data[FILTERS_KEY]
    return unless filters

    races = Array(filters["races"])
    ballot_order = Array(filters["race_ballot_order"])

    problems = []
    (races - ballot_order).each do |race|
      problems << %(  - race "#{race}" is in `races` but missing from `race_ballot_order`)
    end
    (ballot_order - races).each do |race|
      problems << %(  - race "#{race}" is in `race_ballot_order` but missing from `races`)
    end

    return if problems.empty?

    raise ["Stance filter validation failed:", *problems,
           "`races` and `race_ballot_order` in _data/stance_filters.yml must contain the same entries."].join("\n")
  end

  def self.validate(site)
    filters = site.data[FILTERS_KEY]
    return unless filters

    valid_tags = Array(filters["tags"])
    valid_races = Array(filters["races"]).to_set
    valid_parties = Array(filters["parties"]).to_set
    tag_set = valid_tags.to_set
    tag_lower = valid_tags.each_with_object({}) { |t, h| h[t.downcase] = t }

    problems = []

    question_ids_by_state = {}
    questions = site.data[QUESTIONS_KEY]
    if questions
      questions.each do |state_slug, entries|
        next if state_slug == "_blank"
        seen_ids = {}
        Array(entries).each_with_index do |entry, idx|
          label = "stance_questions/#{state_slug}.yml[#{idx}]"

          unless entry.is_a?(Hash)
            problems << "  - #{label}: entry is not a mapping"
            next
          end

          QUESTION_REQUIRED_FIELDS.each do |f|
            if entry[f].nil? || (entry[f].is_a?(String) && entry[f].strip.empty?)
              problems << %(  - #{label}: missing required field "#{f}")
            end
          end

          id = entry["id"]
          if id && !id.to_s.strip.empty?
            if seen_ids.key?(id)
              problems << %(  - #{label}: id "#{id}" is duplicated (also at index #{seen_ids[id]}))
            else
              seen_ids[id] = idx
            end
          end

          validate_tags(label, entry["tag"], tag_set, tag_lower, problems)

          # Race-specific questions are displayed on state pages, so validate
          # their applicability against the same canonical race list used by
          # candidate responses and explorer filters.
          question_races = entry["races"]
          unless question_races.nil?
            if !question_races.is_a?(Array)
              problems << %(  - #{label}: races must be a YAML list)
            elsif question_races.empty?
              problems << %(  - #{label}: races is empty; omit it when the question applies to all races)
            else
              question_races.each do |race|
                unless valid_races.include?(race)
                  problems << %(  - #{label}: race "#{race}" is not in stance_filters.yml races)
                end
              end
            end
          end
        end
        question_ids_by_state[state_slug] = seen_ids.keys.to_set
      end
    end

    responses = site.data[RESPONSES_KEY]
    if responses
      responses.each do |state_slug, entries|
        next if state_slug == "_blank"
        valid_question_ids = question_ids_by_state[state_slug] || Set.new
        primary_by_candidate = {}
        Array(entries).each_with_index do |entry, idx|
          label = "#{state_slug}.yml[#{idx}] — #{entry.is_a?(Hash) ? ([entry["candidate_first_name"], entry["candidate_last_name"]].compact.join(" ").then { |n| n.empty? ? "(unknown candidate)" : n }) : "(non-hash entry)"}"

          unless entry.is_a?(Hash)
            problems << "  - #{label}: entry is not a mapping"
            next
          end

          RESPONSE_REQUIRED_FIELDS.each do |f|
            if entry[f].nil? || (entry[f].is_a?(String) && entry[f].strip.empty?)
              problems << %(  - #{label}: missing required field "#{f}")
            end
          end

          if entry["state"] && entry["state"].to_s != state_slug.to_s
            problems << %(  - #{label}: state "#{entry["state"]}" does not match file slug "#{state_slug}")
          end

          if entry["race"] && !valid_races.include?(entry["race"])
            problems << %(  - #{label}: race "#{entry["race"]}" is not in stance_filters.yml races)
          end

          if entry["party"] && !valid_parties.include?(entry["party"])
            problems << %(  - #{label}: party "#{entry["party"]}" is not in stance_filters.yml parties)
          end

          district = entry["district"]
          if !district.nil? && district.to_s.strip.empty?
            problems << %(  - #{label}: district is present but blank; omit it for statewide races)
          end

          date = entry["date"]
          unless date.nil?
            ok = date.is_a?(Date) || (date.is_a?(String) && (Date.parse(date) rescue nil))
            problems << %(  - #{label}: date "#{date}" is not a valid ISO date) unless ok
          end

          question_ref = entry["question"]
          if question_ref && !question_ref.to_s.strip.empty? && !valid_question_ids.include?(question_ref)
            problems << %(  - #{label}: question "#{question_ref}" does not match any question id in stance_questions/#{state_slug}.yml)
          end

          race_val = entry["race"]
          county_race_val = entry["county_race"]
          county_race_blank = county_race_val.nil? || (county_race_val.is_a?(String) && county_race_val.strip.empty?)
          if race_val == COUNTY_RACE_RACE && county_race_blank
            problems << %(  - #{label}: race "#{COUNTY_RACE_RACE}" requires county_race to be populated)
          elsif !county_race_blank && race_val != COUNTY_RACE_RACE
            problems << %(  - #{label}: county_race "#{county_race_val}" is only allowed when race is "#{COUNTY_RACE_RACE}")
          end

          primary = entry["primary_candidate"]
          unless primary.nil?
            if primary != true && primary != false
              problems << %(  - #{label}: primary_candidate "#{primary}" must be true or false)
            end
          end
          # primary_candidate is a property of the candidate, not the individual
          # response, so it must be the same on every row for a given candidate.
          # A missing field and false mean the same thing.
          cand_name = [entry["candidate_first_name"], entry["candidate_last_name"]].compact.join(" ")
          unless cand_name.strip.empty?
            (primary_by_candidate[cand_name] ||= Set.new) << (primary == true)
          end
        end

        primary_by_candidate.each do |cand_name, values|
          if values.size > 1
            problems << %(  - #{state_slug}.yml — #{cand_name}: primary_candidate is inconsistent across responses (must be the same on every row))
          end
        end
      end
    end

    return if problems.empty?

    message = ["Stance response validation failed:", *problems,
               "Valid values are defined in _data/stance_filters.yml."].join("\n")
    raise message
  end

  # Every state page must declare the front matter its body and the shared
  # includes depend on. These are the single source of truth for the state's
  # code, display name, contact link, and voter-lookup link across the map,
  # filter bar, response cards, responses.json feed, and page header — a missing
  # value silently leaks blanks or broken links, so fail the build instead. This
  # list mirrors the "Required front matter" section documented in template.html.
  #
  # State pages are identified by their location (files under the states
  # directory) rather than by the presence of a `state` field, so that a page
  # which forgot `state` entirely is still caught instead of silently ignored.
  TEMPLATE_STATE_CODE = "xx".freeze
  STATE_PAGE_DIR = "stance/states/".freeze
  TEMPLATE_BASENAME = "template.html".freeze
  STATE_PAGE_REQUIRED_FIELDS = %w[
    state state_name demonym_plural team_email ballot_lookup_url ballot_lookup_label
  ].freeze

  def self.validate_state_pages(site)
    collection = site.collections["initiatives"]
    return unless collection

    problems = []
    collection.docs.each do |doc|
      path = doc.relative_path.to_s
      next unless path.include?(STATE_PAGE_DIR)
      next if File.basename(path) == TEMPLATE_BASENAME
      # The template placeholder renders at the `xx` code; skip any copy still
      # carrying it (it isn't a real, published state page).
      next if doc.data["state"].to_s == TEMPLATE_STATE_CODE

      STATE_PAGE_REQUIRED_FIELDS.each do |f|
        value = doc.data[f]
        if value.nil? || (value.is_a?(String) && value.strip.empty?)
          problems << %(  - #{path}: missing required front matter "#{f}")
        end
      end
    end

    return if problems.empty?

    raise ["Stance state page validation failed:", *problems,
           "Every state page must define these non-empty front-matter fields: #{STATE_PAGE_REQUIRED_FIELDS.join(", ")}."].join("\n")
  end

  def self.validate_tags(label, tags, tag_set, tag_lower, problems)
    return if tags.nil?
    tag_list = tags.is_a?(Array) ? tags : [tags]
    tag_list.each do |tag|
      next if tag_set.include?(tag)
      hint = tag_lower[tag.to_s.downcase]
      suffix = hint ? %( (did you mean "#{hint}"?)) : ""
      problems << %(  - #{label}: tag "#{tag}" is not in stance_filters.yml tags#{suffix})
    end
  end
end

Jekyll::Hooks.register :site, :post_read do |site|
  StanceResponseValidator.validate_filters(site)
  StanceResponseValidator.validate_state_pages(site)
  StanceResponseValidator.validate(site)
end
