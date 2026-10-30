---
title: "Team"
layout: gridlay
sitemap: false
permalink: /team/
---

## Meet the Team

<div class="d-grid gap-4 team-members" markdown="0">
{% for member in site.data.members %}
  <div class="team-members__card">
    <div class="team-members__entry row gx-3 h-100">
      <div class="col-4">
        <img class="team-members__portrait img-fluid m-0" src="{{ site.url }}{{ site.baseurl }}/images/team_headshots/{{ member.photo }}" alt="" loading="lazy" />
      </div>
      <div class="col-8 d-flex flex-column align-items-start">
        <div class="d-flex flex-wrap align-items-center column-gap-2 mb-2">
          <h3 class="h5 m-0">{{ member.name }}</h3>
          {% if member.pronouns %}<span class="fst-italic small">{{ member.pronouns }}</span>{% endif %}
        </div>
        <div class="team-members__bio" id="team-bio-{{ forloop.index }}">
          <p class="mb-2">{{ member.info }}</p>
        </div>
        <button class="team-members__toggle btn btn-link p-0 m-0" type="button" data-bs-toggle="collapse" data-bs-target="#team-bio-{{ forloop.index }}" aria-controls="team-bio-{{ forloop.index }}" aria-expanded="false" data-member-name="{{ member.name | escape }}" hidden>Read more</button>
      <div class="d-flex flex-wrap gap-3 mt-2 team-members__links">
        {% if member.website %}<a class="m-0 py-1 px-0 lh-1" href="{{ member.website }}" target="_blank" rel="noopener" aria-label="{{ member.name }} website" title="{{ member.name }} website"><i class="fa-solid fa-globe" aria-hidden="true"></i></a> {% endif %}
        {% if member.email %}<a class="m-0 py-1 px-0 lh-1" href="mailto:{{ member.email }}" aria-label="Email {{ member.name }}" title="Email {{ member.name }}"><i class="fa-solid fa-envelope" aria-hidden="true"></i></a> {% endif %}
        {% if member.linkedin %} <a class="m-0 py-1 px-0 lh-1" href="https://www.linkedin.com/in/{{ member.linkedin }}" target="_blank" rel="noopener" aria-label="{{ member.name }} on LinkedIn" title="{{ member.name }} on LinkedIn"><i class="fa-brands fa-linkedin" aria-hidden="true"></i></a> {% endif %}
        {% if member.bluesky %} <a class="m-0 py-1 px-0 lh-1" href="https://bsky.app/profile/{{ member.bluesky }}" target="_blank" rel="noopener" aria-label="{{ member.name }} on Bluesky" title="{{ member.name }} on Bluesky"><i class="fa-brands fa-bluesky" aria-hidden="true"></i></a> {% endif %}
        {% if member.medium %} <a class="m-0 py-1 px-0 lh-1" href="https://medium.com/@{{ member.medium }}" target="_blank" rel="noopener" aria-label="{{ member.name }} on Medium" title="{{ member.name }} on Medium"><i class="fa-brands fa-medium" aria-hidden="true"></i></a> {% endif %}
        {% if member.instagram %} <a class="m-0 py-1 px-0 lh-1" href="https://www.instagram.com/{{ member.instagram }}" target="_blank" rel="noopener" aria-label="{{ member.name }} on Instagram" title="{{ member.name }} on Instagram"><i class="fa-brands fa-instagram" aria-hidden="true"></i></a> {% endif %}
        {% if member.twitter %} <a class="m-0 py-1 px-0 lh-1" href="https://x.com/{{ member.twitter }}" target="_blank" rel="noopener" aria-label="{{ member.name }} on X" title="{{ member.name }} on X"><i class="fa-brands fa-x-twitter" aria-hidden="true"></i></a> {% endif %}
      </div>
      </div>
    </div>
  </div>
{% endfor %}
</div>

<script src="{{ "/assets/javascript/team-bios.js" | relative_url }}" defer></script>
