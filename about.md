---
layout: page
permalink: /about/index.html
title: Ping Jin
tags: [Self-Introduction]
imagefeature: fourseasons.jpg
chart: true
---
<figure>
  <img src="{{ site.baseurl }}/images/bio.png" alt="Ping Jin" height="50">
  <figcaption>Ping Jin</figcaption>
</figure>

{% assign total_words = 0 %}
{% assign total_readtime = 0 %}
{% assign featuredcount = 0 %}

{% for post in site.posts %}
    {% assign post_words = post.content | strip_html | number_of_words %}
    {% assign ert = post_words | divided_by:180 %}
    {% assign ertremainder = post_words | modulo:180 %}
        {% if ertremainder >= 90 %}
            {% assign readtime = ert | plus:1 %}
        {% else %}
            {% assign readtime = ert %}
        {% endif %}
    {% assign total_words = total_words | plus: post_words %}
    {% assign total_readtime = total_readtime | plus: readtime %}
    {% if post.featured %}
    {% assign featuredcount = featuredcount | plus: 1 %}
    {% endif %}
{% endfor %}


My name is **Ping Jin**, and this is my personal blog (Template from Hossain Mohd. Faysal, THANKS A LOT). It currently has {{ site.posts | size }} posts in {{ site.categories | size }} categories which combinedly have {{ total_words }} words, which will take an average reader approximately {{ total_readtime }} minutes to read. {% if featuredcount != 0 %}There are <a href="{{ site.baseurl }}/featured">{{ featuredcount }} featured posts</a>, you should definitely check those out.{% endif %} The most recent post is {% for post in site.posts limit:1 %}{% if post.description %}<a href="{{ site.baseurl }}{{ post.url }}" data-toggle="tooltip" title="{{ post.description }}">"{{ post.title }}"</a>{% else %}<a href="{{ site.baseurl }}{{ post.url }}" data-toggle="tooltip" title="{{ post.description }}" data-toggle="tooltip" title="Read more about {{ post.title }}">"{{ post.title }}"</a>{% endif %}{% endfor %} which was published on {% for post in site.posts limit:1 %}{% assign modifiedtime = post.modified | date: "%Y%m%d" %}{% assign posttime = post.date | date: "%Y%m%d" %}<time datetime="{{ post.date | date_to_xmlschema }}" class="post-time">{{ post.date | date: "%d %b %Y" }}</time>{% if post.modified %}{% if modifiedtime != posttime %} and last modified on <time datetime="{{ post.modified | date: "%Y-%m-%d" }}" itemprop="dateModified">{{ post.modified | date: "%d %b %Y" }}</time>{% endif %}{% endif %}{% endfor %}. The last commit was on {{ site.time | date: "%A, %d %b %Y" }} at {{ site.time | date: "%I:%M %p" }} [UTC](http://en.wikipedia.org/wiki/Coordinated_Universal_Time "Temps Universel Coordonné").

<div class="chart" id="chartdiv" style="width: 100%; height: 500px; margin-bottom: 20px;" ></div>
<figcaption>Number of Posts Breakdown</figcaption>


I am a second year master student in University of Alberta, supervised by [Prof. Russell Greiner](http://webdocs.cs.ualberta.ca/~greiner/). My current research focuses on applying sparse methods to [patient-specific survival curve prediction](http://pssp.srv.ualberta.ca/). 

I am now looking for a job related to machine leanring or general software development. Here is my [CV]({{ site.baseurl }}/cv/cv.pdf).

<!-- amCharts javascript code -->
<script type="text/javascript">
  AmCharts.makeChart("chartdiv",
    {
      "type": "pie",
      "pathToImages": "http://cdn.amcharts.com/lib/3/images/",
      "balloonText": "[[title]]<br><span style='font-size:14px'><b>[[value]]</b> ([[percents]]%)</span>",
      "innerRadius": "40%",
      "labelRadius": 10,
      "labelRadiusField": "Not set",
      "startRadius": "10%",
      "colorField": "Not set",
      "descriptionField": "Not set",
      "hoverAlpha": 0.75,
      "outlineThickness": 0,
      "startEffect": "elastic",
      "titleField": "category",
      "valueField": "number-of-posts",
      "allLabels": [],
      "balloon": {},
      "legend": {
        "align": "center",
        "markerType": "square"
      },
      "titles": [],
      "dataProvider": [
{% assign tags_list = site.categories %}  
  {% if tags_list.first[0] == null %}
    {% for tag in tags_list %} 
        {
          "category": "{{ tag | capitalize }}",
          "number-of-posts": {{ site.tags[tag].size }}
        },
    {% endfor %}
  {% else %}
    {% for tag in tags_list %} 
        {
          "category": "{{ tag[0] | capitalize }}",
          "number-of-posts": {{ tag[1].size }}
        },
    {% endfor %}
  {% endif %}
{% assign tags_list = nil %}
      ]
    }
  );
</script>