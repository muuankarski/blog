---
layout: default
title: Markus Kainu home page
---

Welcome to my home page
------------------

I'm a **quantitatively orientated** social scientist specialized in **poverty** and **inequalities** in **post-socialist space**, and in **open source research software carpentry**. Based in Helsinki, Finland. Blog discusses mainly how R language can be applied in social science research. Mostly in English, sometimes in Finnish.

Tervetuloa kotisivuilleni
------------------

Olen kvantitatiivisesti suuntautunut yhteiskuntatieteilijä, joka on erikoistunut **köyhyyteen** ja **taloudelliseen eriarvoisuuteen** **post-sosialistisissa maissa**, sekä **avoimen koodin tutkimusohjelmistojen nikkarointiin**. Blogissa käsittelen avoimen koodin ohjelmistojen käyttöä yhteiskuntatieteellisessä tutkimuksessa, painottaen erityisesti R-kieltä.

Contact me
------------------

You can contact me via email at <a href="mailto:markuskainu@gmail.com">markuskainu@gmail.com</a> or on <a href="http://twitter.com/muuankarski">twitter</a>.

Latest in the blog
-------------------

Blog RSS here: <a title="blog RSS" href="http://markuskainu.fi/blog/feed.xml">
                    <i class="icon-rss"></i></a>

<div id="posts">
    {% for post in site.posts offset: 0 limit: 3 %}
        <small style="color: #999;">{{ post.date | date: "%b %d, %Y" }}</small> 
        <a href="{{ post.url }}">{{ post.title }}</a>
        <br />
        {% if post.summary %}
            <small>{{ post.summary }}</small>
        {% endif %}
    {% endfor %}
    </div>


