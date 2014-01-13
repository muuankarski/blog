---
layout: post
title:  "Maailmanpankin data WDI-paketilla"
date:   2013-08-05 11:00:45
categories: R-project
---

# Tässä esimerkki




{% highlight r %}
library(WDI)
dat <- WDI(indicator = c("NY.GDP.PCAP.KD"), country = c("CN", "RU", "IN", "BR"), 
    start = 1980, end = 2012)
library(ggplot2)
ggplot(dat, aes(year, NY.GDP.PCAP.KD, color = country)) + geom_line() + geom_point() + 
    labs(x = "year", y = "GDP per capita")
{% endhighlight %}



{% highlight text %}
## Warning: Removed 9 rows containing missing values (geom_path).
## Warning: Removed 9 rows containing missing values (geom_point).
{% endhighlight %}

![center](/figs/2013-08-05-maailmanpankin-data/unnamed-chunk-1.png) 





[jekyll-gh]: https://github.com/mojombo/jekyll
[jekyll]:    http://jekyllrb.com
