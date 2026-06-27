---
title: "About"
layout: gridlay
sitemap: false
permalink: /about/
---

## About SNAP
Scientist Network for Advancing Policy (SNAP) was conceptualized in early 2025 and formed through a (still ongoing!) gathering of science policy-minded early career researchers from across the United States. SNAP is a nationwide non-partisan grassroots organization.

#### Looking for SNAP's upcoming meetings and events?
Check out our [events calendar]({{ site.url }}{{ site.baseurl }}/calendar)!

### Mission Statement 
We are a coalition of early-career scientists dedicated to mobilizing for large-scale initiatives and bridging gaps between scientists, their communities, and the general public. Our mission is to inspire and engage fellow scientists by establishing a peer network, developing and sharing resources, and instigating meaningful change.

## Member Organizations

<div class='jumbotron'>
{% assign number_printed = 0 %}
{% for member in site.data.member_orgs %}

{% assign even_odd = number_printed | modulo: 2 %}

{% if even_odd == 0 %}
<div class="row">
{% endif %}

<div class="col-sm-2">
<img src="{{ site.url }}{{ site.baseurl }}/images/member_org_logos/{{ member.photo }}" width="100%" style="max-width:250px"/>
</div>
<div class="col-sm-4 col-xs-12">
  <h4>{{ member.name }}</h4>
  <i>{{ member.info }}<br></i>
<div style="display: flex; gap: 0.25em; align-items: flex-start; flex-wrap: wrap;">
  {% if member.website %}<a href="{{ member.website }}" target="_blank" rel="noopener" aria-label="{{ member.name }} website" title="{{ member.name }} website"><i class="fa-solid fa-globe fa-2x" aria-hidden="true"></i></a>{% endif %}
  {% if member.email %}<a href="mailto:{{ member.email }}" aria-label="Email {{ member.name }}" title="Email {{ member.name }}"><i class="fa-solid fa-envelope fa-2x" aria-hidden="true"></i></a>{% endif %}
  {% if member.bluesky %}<a href="https://bsky.app/profile/{{ member.bluesky }}" target="_blank" rel="noopener" aria-label="{{ member.name }} on Bluesky" title="{{ member.name }} on Bluesky"><i class="fa-brands fa-bluesky fa-2x" aria-hidden="true"></i></a>{% endif %}
  {% if member.instagram %}<a href="https://www.instagram.com/{{ member.instagram }}" target="_blank" rel="noopener" aria-label="{{ member.name }} on Instagram" title="{{ member.name }} on Instagram"><i class="fa-brands fa-instagram fa-2x" aria-hidden="true"></i></a>{% endif %}
  {% if member.linkedin %}<a href="https://www.linkedin.com/company/{{ member.linkedin }}/" target="_blank" rel="noopener" aria-label="{{ member.name }} on LinkedIn" title="{{ member.name }} on LinkedIn"><i class="fa-brands fa-linkedin fa-2x" aria-hidden="true"></i></a>{% endif %}
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

{% if site.data.grants %}

<div class="jumbotron">
  <h3>Grants</h3>
  <ul>
    {% for grant in site.data.grants %}
      <li>{{ grant.name }}</li>
    {% endfor %}
  </ul>
</div>
{% endif %}

{% if site.data.awards %}

<div class="jumbotron">
  <h3>Awards</h3>
  <ul>
    {% for award in site.data.awards %}
      <li>{{ award.name | replace: "-","&#8211;" }}</li>
    {% endfor %}
  </ul>
</div>
{% endif %}

{% if site.data.funders %}

<div class="jumbotron">
  <h4>Sponsors</h4>
  <div style='display:block; text-align:center; margin-left:auto; margin-right:auto;'>
  {% for funder in site.data.funders %}<a href="{{ funder.url }}" target="_blank"><img src='{{ site.url }}{{ site.baseurl }}/images/{{ funder.image }}' style='max-height: 80px; max-width: 200px; margin: 1%'/></a>{% endfor %}
  </div>
</div>
{% endif %}
