---
layout: post
title:  "rustfare-package and using Rosstat regional statistics"
date:   2013-08-08 15:53:45
categories: R-project
---

I have been working on Russian statistical data a lot during this year. However, accessing many open data sources has proven to be cumbersome. One example is mighty [regional data resource by Rosstat](http://www.gks.ru/wps/wcm/connect/rosstat_main/rosstat/ru/statistics/publications/catalog/doc_1138623506156). To facilitate access to this and other data sources I begun to write package for R-language called [rustfare](http://markuskainu.fi/rustfare). Below you find some key characteristics of the rustfare at this point in time. It will be improved and extended constantly so make sure you have the latest version installed and that you follow the up-to-date instructions. I will announce major updates through this blog and my twitter.

## rustfare-package

- The rustfare package pools together tools for searching, extracting, and formatting welfare data on Russian Federation from different data providers. 
- The rustfare functions are named according to data provider or the data set. 
- Currently there is data available from: 
    - Rosstat Regional Statistics, 
    - OECD, 
    - Quality of Governance -institute and
    - GADM database of Global Administrative Areas. 
    - World Bank World Development Indicators on Russian Federation can be accessed using [WDI-package](http://cran.r-project.org/web/packages/WDI/index.html) (for examples, see: [markuskainu.fi/r-tutorial/wb/](http://markuskainu.fi/r-tutorial/wb/)
- Currently I'm working on incorporating also [census data from 2002](http://std.gmcrosstata.ru/webapi/opendatabase?id=vpn2002_pert) and [election data from duma election 2011](http://www.vybory.izbirkom.ru/region/region/izbirkom?action=show&root=1&tvd=100100028713304&vrn=100100028713299&region=0&global=1&sub_region=0&prver=0&pronetvd=null&vibid=100100028713304&type=233) with the package

## Installation


{% highlight r %}
library(devtools)
install_github(repo = "rustfare", username = "muuankarski")
library(rustfare)
{% endhighlight %}


## Examples: Rosstat regional statistics

[Rosstat regional statistic](http://www.gks.ru/wps/wcm/connect/rosstat_main/rosstat/ru/statistics/publications/catalog/doc_1138623506156) includes values of the indicators on three levels:

1. federal level
2. federal district level
3. regional level

To dowload the data you may use `GetRosstat()`-function that requires two arguments, 

1. `indicator` (from the listing above), 
2. `level` (federal/federal_district/region)

The code below returns a dataset at **federal district level** on **infant mortality** and plots a line graph over time.



{% highlight r %}
library(rustfare)  # load rustfare for obtaining the data
library(ggplot2)  # load ggplot2 for plotting
dat <- GetRosstat("infant_mortality_rate", "federal_district")
head(dat, 3)  # print the first 6 rows of data.frame
{% endhighlight %}



{% highlight text %}
##        id_name                               region year value
## 1 дальневокруг Дальневосточный\r\nфедеральный округ 1995  20.5
## 2 дальневокруг Дальневосточный\r\nфедеральный округ 2001  18.1
## 3 дальневокруг Дальневосточный\r\nфедеральный округ 2000  18.6
##                           region_ru                    region_en
## 1 Дальневосточный федеральный округ Far Eastern Federal District
## 2 Дальневосточный федеральный округ Far Eastern Federal District
## 3 Дальневосточный федеральный округ Far Eastern Federal District
##              level id_shape             indicator
## 1 federal_district        4 infant_mortality_rate
## 2 federal_district        4 infant_mortality_rate
## 3 federal_district        4 infant_mortality_rate
{% endhighlight %}



{% highlight r %}
ggplot(dat, aes(x = year, y = value, color = region_en)) + geom_point() + geom_line() + 
    geom_text(data = subset(dat, year == 2010), aes(x = year, y = value, color = region_en, 
        label = region_en), size = 3, hjust = 1) + theme(legend.position = "none")
{% endhighlight %}

![Infant mortality rates at federal district level](/figs/2013-08-08-rustfare-rosstat-regional/rosstat.png) 


Next chunk of code extracts the same indicators but at the regional level



{% highlight r %}
library(rustfare)  # load rustfare for obtaining the data
library(ggplot2)  # load ggplot2 for plotting
dat <- GetRosstat("infant_mortality_rate", "region")
head(dat, 3)  # print the first 6 rows of data.frame
{% endhighlight %}



{% highlight text %}
##           region       region_en year value  level id_shape
## 1 Алтайский край Altai Territory 2005  11.5 region     2513
## 2 Алтайский край Altai Territory 1995  20.8 region     2513
## 3 Алтайский край Altai Territory 2008   9.1 region     2513
##               indicator
## 1 infant_mortality_rate
## 2 infant_mortality_rate
## 3 infant_mortality_rate
{% endhighlight %}



{% highlight r %}
ggplot(dat, aes(x = year, y = value, color = region_en)) + geom_point() + geom_line() + 
    geom_text(data = subset(dat, year == 2010), aes(x = year, y = value, color = region_en, 
        label = region_en), size = 3, hjust = 1) + theme(legend.position = "none")
{% endhighlight %}

![Infant mortality rates at regional level](/figs/2013-08-08-rustfare-rosstat-regional/rosstat2.png) 






[jekyll-gh]: https://github.com/mojombo/jekyll
[jekyll]:    http://jekyllrb.com
