---
layout: post
title:  "rustfare-package: Spatial visualization using Global Administrative Areas -data"
date:   2013-08-12 11:53:45
categories: R-project
---

rustfare has functions for downloading a spatial shapefile from [Global Administrative Areas (GADM)](http://www.gadm.org/) database that can be further used to for example plot the data from Rosstat regional data.

In this post I will demonstrate how to access GADM geographical data and how to combine data from Rosstat Regional Statistics with GADM to visualize the data.

## Accessing the GADM data using rustfare-package

Function `GetRusGADM()` downloads the shapefile at desired level and returns a `SpatialPolygonDataFrame`. `Level` argument accepts four values:

- `federal`: whole country
- `federal_districts`: Federal districts (8)
- `region`: administrative boundaries at the level of federal regions/oblasts (82)
- `rayon`: administrative boundaries at the level of rayons/krais



{% highlight r %}
shapefile <- GetRusGADM(level)
{% endhighlight %}


## Plotting shapefiles

Once you have downloaded the `SpatialPolygonDataFrame` you can plot the  the boundaries at different level with following code chunks.

### At federal level


{% highlight r %}
library(rustfare)
shapefile <- GetRusGADM("federal")
plot(shapefile)
{% endhighlight %}

![center](/figs/2013-08-12-rustfare-spatial-visualization-gadm/map1.png) 


### At federal district level


{% highlight r %}
library(rustfare)
shapefile <- GetRusGADM("federal_district")
plot(shapefile)
{% endhighlight %}

![center](/figs/2013-08-12-rustfare-spatial-visualization-gadm/map2.png) 


### At regional level


{% highlight r %}
library(rustfare)
shapefile <- GetRusGADM("region")
plot(shapefile)
{% endhighlight %}

![center](/figs/2013-08-12-rustfare-spatial-visualization-gadm/map3.png) 


### At rayon level


{% highlight r %}
library(rustfare)
shapefile <- GetRusGADM("rayon")
plot(shapefile)
{% endhighlight %}

![center](/figs/2013-08-12-rustfare-spatial-visualization-gadm/map4.png) 




## Merging Rosstat Regional data and visualising it

In the below I will show two ways to visualise the data. I'm more familiar with **ggplot2**-graphics, and here I'm also taking it a bit further than using `spplot`-function from **sp**-package.

### Using maptools and sp

I'm downloading data on life expectancy of men at regional level from Rosstat.


{% highlight r %}
library(rustfare)
dat <- GetRosstat("life_expectancy_men", "region")
dat09 <- subset(dat, year == 2009)
{% endhighlight %}


Then I'm downloading the shapefile at federal districh level, naming the rows as required for `spCbind`-function, ordering the datas and then combining them

To be able to join the data they both must have a) equal number of rows and b) the rownames must match. Lets first give both data rownames that can be used in combining the data. Then let's order the both datas according to rownames. At last, lets see if there are same number of rows in both datas.


{% highlight r %}
shape <- GetRusGADM("region")
library(maptools)
# Remove case with NA id_shape (moscow)
dat09 <- dat09[!is.na(dat09$id_shape), ]
row.names(dat09) <- dat09$id_shape
row.names(shape) <- as.character(shape$ID_1)
dat09 <- dat09[order(row.names(dat09)), ]
shape <- shape[order(row.names(shape)), ]
dim(dat09)
{% endhighlight %}



{% highlight text %}
## [1] 80  7
{% endhighlight %}



{% highlight r %}
dim(shape)
{% endhighlight %}



{% highlight text %}
## [1] 82 16
{% endhighlight %}


As we deleted some cases from Rosstat data it now has two cases less than `SpatialPolygonDataFrame` before, we have to remove those rows from `SpatialPolygonDataFrame`. To find out what they are we use `setdiff()-function and we can see they are 2521 and 2530. We remove them and combine the datas.



{% highlight r %}
setdiff(row.names(shape), row.names(dat09))
{% endhighlight %}



{% highlight text %}
## [1] "2521" "2530"
{% endhighlight %}



{% highlight r %}
shape <- shape[!row.names(shape) %in% c("2521", "2530"), ]
df <- spCbind(shape, dat09)
{% endhighlight %}


Simple grey scale plot can be done as follow


{% highlight r %}
library(sp)
spplot(df, "value", col.regions = grey.colors(20, 0.9, 0.3))
{% endhighlight %}

![center](/figs/2013-08-12-rustfare-spatial-visualization-gadm/mapcombine3.png) 


## Using ggplot2

**ggplot2** is not perhaps the ideal choice for plotting spatial data as `SpatialPolygonDataFrame` has to be converted into regular data.frame using `fortify` and this procedure cannot be reversed very easy. However, once you have fortified the data you can take advantage of all the neat functionalities of ggplot2-package.

We will use the code above for the great part. As we want to plot all the years available as facets of the same plot we have to alter the code in two ways. First, not to subset the data and, second, to convert it into **wide** format from the default **long** format that **rustfare** provides you with. Data will be **casted** into wide format using `dcast`-function in **reshape2**-package.


{% highlight r %}
library(rustfare)
dat <- GetRosstat("life_expectancy_men", "region")
# cast the data into wide format
library(reshape2)
dat.w <- dcast(dat, region_en + id_shape ~ year, value.var = "value")
{% endhighlight %}


Then the data in wide format will be joined with shapefile from GADM.


{% highlight r %}
shape <- GetRusGADM("region")
library(maptools)
dat.w <- dat.w[!is.na(dat.w$id_shape), ]
row.names(dat.w) <- dat.w$id_shape
row.names(shape) <- as.character(shape$ID_1)
dat.w <- dat.w[order(row.names(dat.w)), ]
shape <- shape[order(row.names(shape)), ]
# from above
difference <- setdiff(row.names(shape), row.names(dat.w))
shape <- shape[!row.names(shape) %in% difference, ]
# 
df <- spCbind(shape, dat.w)
{% endhighlight %}


Then the `SpatialPolygonDataFrame` must be converted into regular `data.frame`, and I'm using the `fortify`-function from **ggplot2**-package for it. We also need **rgeos*-package for this conversion.



{% highlight r %}
library(ggplot2)
library(rgeos)
df$id <- rownames(df@data)
map.points <- fortify(df, region = "id")
map.df <- merge(map.points, df, by = "id")
dim(map.df)
{% endhighlight %}



{% highlight text %}
## [1] 541696     28
{% endhighlight %}



{% highlight r %}
head(map.df, 2)
{% endhighlight %}



{% highlight text %}
##     id  long   lat order  hole piece  group ID_0 ISO NAME_0 ID_1 NAME_1
## 1 2511 39.65 45.16     1 FALSE     1 2511.1  190 RUS Russia 2511 Adygey
## 2 2511 39.68 45.16     2 FALSE     1 2511.1  190 RUS Russia 2511 Adygey
##                                                                           VARNAME_1
## 1 Adygea|Adygeya|Adygheya|Republic of Adygeya|Adygeyskaya A.Obl.|Respublika Adygeya
## 2 Adygea|Adygeya|Adygheya|Republic of Adygeya|Adygeyskaya A.Obl.|Respublika Adygeya
##           NL_NAME_1 HASC_1 CC_1     TYPE_1 ENGTYPE_1 VALIDFR_1 VALIDTO_1
## 1 ?????????? ??????  RU.AD 4301 Respublika  Republic   Unknown   Present
## 2 ?????????? ??????  RU.AD 4301 Respublika  Republic   Unknown   Present
##   REMARKS_1 Shape_Leng Shape_Area region_en id_shape X2000 X2005 X2009
## 1      <NA>      9.508     0.9129    Adygea     2511 62.07 61.91 64.38
## 2      <NA>      9.508     0.9129    Adygea     2511 62.07 61.91 64.38
{% endhighlight %}


Now data we want to visualize is as a regular `data.frame` and ready for plotting. But one more thing is need: **ggplot2** eats data in long format, so we have to melt the data into long format using `melt`-function from **reshape2**-package.


{% highlight r %}
# As we want to plot map faceted by years 2000, 2005 and 2009 we have to
# melt it into long format
library(reshape2)
map.df.l <- melt(data = map.df, id.vars = c("id", "long", "lat", "group"), measure.vars = c("X2000", 
    "X2005", "X2009"))
# lets tweak a bit and remove X's from year values and make it into
# numerical
map.df.l$variable <- str_replace_all(map.df.l$variable, "X", "")
map.df.l$variable <- factor(map.df.l$variable)
map.df.l$variable <- as.numeric(levels(map.df.l$variable))[map.df.l$variable]
dim(map.df.l)
{% endhighlight %}



{% highlight text %}
## [1] 1625088       6
{% endhighlight %}


As a result we get rather massive data with 1625088 rows and 6 columns. We can then plot this using the following command.


{% highlight r %}
# plot faceted by year
ggplot(map.df.l, aes(long,lat,group=group)) +
  geom_polygon(aes(fill = value)) +
  geom_polygon(data = map.df.l, aes(long,lat), 
               fill=NA, 
               color = "white",
               size=0.1) + # white borders
  coord_map(project="orthographic",
            xlim=c(25,170),
              ylim=c(45,70)) +
  facet_wrap(~variable, ncol=1) +
  theme_minimal()
{% endhighlight %}

![center](/figs/2013-08-12-rustfare-spatial-visualization-gadm/rmapcombineggplot5.png) 


### Plotting the changes from 2000 to 2009

Let's take advantage of data we got after we merged the Rosstat data into `SpatialPolygonDataFrame`, which is `df`. Let's calculate the change from 2000 to 2009 and fortify the data into data.frame. And then we point that **ggplot2** applies red colors for negative values (where life expectancy has worsened) and green color fot positive values (where life expectancy has improved).



{% highlight r %}
df$change <- (df$X2009 - df$X2000)/df$X2000*100
df$X2000 <- NULL
df$X2005 <- NULL
df$X2009 <- NULL
#
library(ggplot2)
library(rgeos)
df$id <- rownames(df@data)
map.points <- fortify(df, region = "id")
map.df <- merge(map.points, df, by = "id")
library(reshape2)
map.df.l <- melt(data = map.df, 
                 id.vars = c("id", "long", 
                             "lat", "group"), 
                 measure.vars = "change")
ggplot(map.df.l, aes(long,lat,group=group)) +
  geom_polygon(aes(fill = value)) +
  scale_fill_gradient2(low = "red", high = "green") +
  geom_polygon(data = map.df.l, aes(long,lat), 
               fill=NA, 
               color = "white",
               size=0.1) + # white borders
  coord_map(project="orthographic",
            xlim=c(25,170),
              ylim=c(45,70)) +
  theme_minimal()
{% endhighlight %}

![center](/figs/2013-08-12-rustfare-spatial-visualization-gadm/rmapcombineggplot6.png) 

{% highlight r %}

{% endhighlight %}



### RosstatMapPlot()-function

There is a `RosstatMapPlot`-function in rustfare that takes `measure`, `year` and `level` as arguments and plots maps using the somewhat similar procedure as above. Have a look at examples below.

### Infant mortality rate at regional level


{% highlight r %}
library(rustfare)
RosstatMapPlot("infant_mortality_rate", 2010, "region")
{% endhighlight %}

![center](/figs/2013-08-12-rustfare-spatial-visualization-gadm/rosstatmap1.png) 


### Average pension size at federal district level


{% highlight r %}
library(rustfare)
RosstatMapPlot("average_size_of_pensions", 2010, "federal_district")
{% endhighlight %}

![center](/figs/2013-08-12-rustfare-spatial-visualization-gadm/rosstatmap2.png) 




[jekyll-gh]: https://github.com/mojombo/jekyll
[jekyll]:    http://jekyllrb.com
