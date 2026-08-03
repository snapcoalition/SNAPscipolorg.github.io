# Questions

Each entry is a question, classified by one or more tags.

Note that the `tag` must be on the master list of tags (`data/stance_filters.yml`). The website build will fail if there is an invalid tag. Tags are case-sensitive.

## Fields
- `id`: must be unique. This field is used to match questions to responses (`question` attribute).
- `question`: the question. Uses Markdown
- `tag`: one tag (or a YAML list of tags) — each must match a value from `tags` in `_data/stance_filters.yml`
- `races` (optional): a non-empty YAML list identifying the races that were asked this question. Each race must match a value from `races` in `_data/stance_filters.yml`. Omit this field when the question applies to all races.
