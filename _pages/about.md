---
title: "About"
layout: gridlay
sitemap: false
permalink: /about/
---

# About SNAP
{: .h2 .mt-0 .mb-3 }

Scientist Network for Advancing Policy (SNAP) was conceptualized in early 2025 and formed through a (still ongoing!) gathering of science policy-minded early career researchers from across the United States. SNAP is a nationwide non-partisan grassroots organization.

## Mission Statement
{: .h3 .mt-4 .mb-3 }

We are a coalition of early-career scientists dedicated to mobilizing for large-scale initiatives and bridging gaps between scientists, their communities, and the general public. Our mission is to inspire and engage fellow scientists by establishing a peer network, developing and sharing resources, and instigating meaningful change.

## SNAPper research
{: .h3 .mt-4 .mb-3 }

[Check out scientific publications by SNAPpers]({{ site.url }}{{ site.baseurl }}/publications)!

## Looking for SNAP's upcoming meetings and events?
{: .h3 .mt-4 .mb-3 }

Check out our [events calendar]({{ site.url }}{{ site.baseurl }}/calendar)!

## Affiliate Organizations
{: .h3 .mt-4 .mb-3 }

<div class="row g-4 member-organizations" markdown="0">
{% for member in site.data.member_orgs %}
  <div class="col-12 col-md-6">
    <div class="d-flex align-items-start gap-3 h-100 member-organizations__entry">
      <img class="member-organizations__logo flex-shrink-0 rounded-0 m-0" src="{{ site.url }}{{ site.baseurl }}/images/member_org_logos/{{ member.photo }}" width="80" height="80" alt="" loading="lazy" />
      <div class="flex-grow-1 member-organizations__details">
        <h3 class="h5 mt-0 mb-2">{{ member.name }}</h3>
        {% if member.info %}<p class="fst-italic mb-2">{{ member.info }}</p>{% endif %}
        <div class="d-flex flex-wrap gap-3 mt-2 member-organizations__links">
        {% if member.website %}<a class="m-0 py-1 px-0 lh-1" href="{{ member.website }}" target="_blank" rel="noopener" aria-label="{{ member.name }} website" title="{{ member.name }} website"><i class="fa-solid fa-globe" aria-hidden="true"></i></a>{% endif %}
        {% if member.email %}<a class="m-0 py-1 px-0 lh-1" href="mailto:{{ member.email }}" aria-label="Email {{ member.name }}" title="Email {{ member.name }}"><i class="fa-solid fa-envelope" aria-hidden="true"></i></a>{% endif %}
        {% if member.bluesky %}<a class="m-0 py-1 px-0 lh-1" href="https://bsky.app/profile/{{ member.bluesky }}" target="_blank" rel="noopener" aria-label="{{ member.name }} on Bluesky" title="{{ member.name }} on Bluesky"><i class="fa-brands fa-bluesky" aria-hidden="true"></i></a>{% endif %}
        {% if member.instagram %}<a class="m-0 py-1 px-0 lh-1" href="https://www.instagram.com/{{ member.instagram }}" target="_blank" rel="noopener" aria-label="{{ member.name }} on Instagram" title="{{ member.name }} on Instagram"><i class="fa-brands fa-instagram" aria-hidden="true"></i></a>{% endif %}
        {% if member.linkedin %}<a class="m-0 py-1 px-0 lh-1" href="https://www.linkedin.com/company/{{ member.linkedin }}/" target="_blank" rel="noopener" aria-label="{{ member.name }} on LinkedIn" title="{{ member.name }} on LinkedIn"><i class="fa-brands fa-linkedin" aria-hidden="true"></i></a>{% endif %}
        </div>
      </div>
    </div>
  </div>
{% endfor %}
</div>

{% if site.data.grants %}

<div class="jumbotron">
  <h2 class="h3 mt-0 mb-3">Grants</h2>
  <ul>
    {% for grant in site.data.grants %}
      <li>{{ grant.name }}</li>
    {% endfor %}
  </ul>
</div>
{% endif %}

{% if site.data.awards %}

<div class="jumbotron">
  <h2 class="h3 mt-0 mb-3">Awards</h2>
  <ul>
    {% for award in site.data.awards %}
      <li>{{ award.name | replace: "-","&#8211;" }}</li>
    {% endfor %}
  </ul>
</div>
{% endif %}

{% if site.data.funders %}

<div class="jumbotron">
  <h2 class="h3 mt-0 mb-3">Sponsors</h2>
  <div style='display:block; text-align:center; margin-left:auto; margin-right:auto;'>
  {% for funder in site.data.funders %}<a href="{{ funder.url }}" target="_blank"><img src='{{ site.url }}{{ site.baseurl }}/images/{{ funder.image }}' style='max-height: 80px; max-width: 200px; margin: 1%'/></a>{% endfor %}
  </div>
</div>
{% endif %}
