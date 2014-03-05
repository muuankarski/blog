---
layout: default
title: Blog
---

The blog
---------------

I will write here mainly about how R language can be applied in social science research. Mostly in English, sometimes in Finnish. Code is run and tested in using latest R-version and latest versions of packages on ubuntu-linux platform. If you have any issues with running the code please comment the post.

**See the source code and version history of blogposts at [GitHub](https://github.com/muuankarski/blog/tree/master/_R)**

<div id="posts">

Blog RSS here: <a title="blog RSS" href="http://easterneurope.github.io/feed.xml">
                    <i class="fa fa-rss-square fa-2x"></i></a>


    {% for post in site.posts offset: 0 limit: 10 %}
        <div style="border-bottom: 1px solid gray; padding: 5px 0;">
        <small style="color: #999;">{{ post.date | date: "%b %d, %Y" }}</small> 
        <a href="{{ post.url }}">{{ post.title }}</a>
        <br />
        {% if post.summary %}
            <small>{{ post.summary }}</small>
        {% endif %}
        </div>
    {% endfor %}

<div style="margin: 15px 0; padding-top: 5px;">
<small>
    <a href="/archive.html" title="an archive of all posts">&larr; More posts</a>
</small>
</div>

</div>
