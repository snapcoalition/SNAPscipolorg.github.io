---
title: "Team"
layout: gridlay
sitemap: false
permalink: /team/
---

## Meet the Team

<div class='jumbotron'>
{% assign number_printed = 0 %}
{% for member in site.data.members %}

{% assign even_odd = number_printed | modulo: 2 %}

{% if even_odd == 0 %}

<div class="row">
{% endif %}

<div class="col-sm-2">
<img src="{{ site.url }}{{ site.baseurl }}/images/team_headshots/{{ member.photo }}" width="100%" style="max-width:250px"/>
</div>
<div class="col-sm-4 col-xs-12">
  <h4>{{ member.name }}</h4>
  {% if member.pronouns %}<h5><i>{{ member.pronouns }}</i></h5> {% endif %}
  <p>{{ member.info }}<br></p>

<div style="display: flex; gap: 0.25em; align-items: flex-start; flex-wrap: wrap;">
{% if member.website %}<a href="{{ member.website }}" target="_blank" rel="noopener" aria-label="{{ member.name }} website" title="{{ member.name }} website"><i class="fa-solid fa-globe fa-2x" aria-hidden="true"></i></a> {% endif %}
{% if member.email %}<a href="mailto:{{ member.email }}" aria-label="Email {{ member.name }}" title="Email {{ member.name }}"><i class="fa-solid fa-envelope fa-2x" aria-hidden="true"></i></a> {% endif %}
{% if member.linkedin %} <a href="https://www.linkedin.com/in/{{ member.linkedin }}" target="_blank" rel="noopener" aria-label="{{ member.name }} on LinkedIn" title="{{ member.name }} on LinkedIn"><i class="fa-brands fa-linkedin fa-2x" aria-hidden="true"></i></a> {% endif %}
{% if member.bluesky %} <a href="https://bsky.app/profile/{{ member.bluesky }}" target="_blank" rel="noopener" aria-label="{{ member.name }} on Bluesky" title="{{ member.name }} on Bluesky"><i class="fa-brands fa-bluesky fa-2x" aria-hidden="true"></i></a> {% endif %}
{% if member.medium %} <a href="https://medium.com/@{{ member.medium }}" target="_blank" rel="noopener" aria-label="{{ member.name }} on Medium" title="{{ member.name }} on Medium"><i class="fa-brands fa-medium fa-2x" aria-hidden="true"></i></a> {% endif %}
{% if member.instagram %} <a href="https://www.instagram.com/{{ member.instagram }}" target="_blank" rel="noopener" aria-label="{{ member.name }} on Instagram" title="{{ member.name }} on Instagram"><i class="fa-brands fa-instagram fa-2x" aria-hidden="true"></i></a> {% endif %}
{% if member.twitter %} <a href="https://x.com/{{ member.twitter }}" target="_blank" rel="noopener" aria-label="{{ member.name }} on X" title="{{ member.name }} on X"><i class="fa-brands fa-x-twitter fa-2x" aria-hidden="true"></i></a> {% endif %}
</div>

</div>
<!-- </div> -->

{% assign number_printed = number_printed | plus: 1 %}

{% if even_odd == 1 %}

</div>
{% endif %}

{% endfor %}

{% assign even_odd = number_printed | modulo: 2 %}
{% if even_odd == 1 %}

</div>
{% endif %}
</div>
