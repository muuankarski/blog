---
layout: default
title: Blog archive
---

<h2>Archive <small>all posts</small></h2>

<div id="posts">

{% for post in site.posts offset: 0 %}
    <div style="border-bottom: 1px solid gray; padding: 5px 0;">
    <small style="color: #999;">{{ post.date | date: "%b %d, %Y" }}</small> 
    <a href="{{ post.url }}">{{ post.title }}</a>
    <br />
    {% if post.summary %}
        <small>{{ post.summary }}</small>
    {% endif %}
    </div>
{% endfor %}

</div>
