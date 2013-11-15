---
layout: post
title:  "Visualising World Values Survey on a Map in R"
date:   2013-11-14 11:23:45
categories: R-project
---

I'm attending the *3rd international annual research conference: "Cultural and Economic changes under cross-national perspective"* at the [Laboratory for Comparative Social Reseach at the Moscow Higher School of Economics](http://lcsr.hse.ru/) currently that gathers together scholars around the world interested in comparative social research. [in my presentation](https://rawgithub.com/muuankarski/attributions/master/attrib_slides.html) I used some spatial visualizations and therefore I received several questions on how to implement such illustrations. In this brief demonstration I will show how to visualize country level data from [World Values Survey](http://www.worldvaluessurvey.org/)(WVS) that is a widely used dataset in this context.

I used the data for the first time yesterday when I downloaded the A & B datasets from year 2005. As I'm not familiar with dataset I won't go into details of if, but just bluntly implement a simple workflow for these spatial illustrations.

## Loading the WVS and extracting the summary statistics

Again due to my incompetence in using the data I'm not using any weights in deriving the summary statistics but just rely on the data as it is. If you want to improve this aspect you can consult for example [my tutorial on using survey-package in R](http://markuskainu.fi/r-tutorial/survey/).

The variable of interest here is `V75: BE WILLING TO FIGHT IN WAR FOR YOUR COUNTRY` as it was discussed in the presentation by professor Ronald Inglehart. I found it interesting in his presentation that all the Scandinavian countries had a relatively high rates for this willingness, and I felt that there may a spatial story behind this, ie. approximity to Russian Federation.

The question behind the key variable is formulated as:

>V75. Of course, we all hope that there will not be another war, but if it were to come to that, would you be
willing to fight for your country? (Code one answer):

And it has values and labels as:

<table>
<tr>
<th>Value</th><th>Label</th>
<tr>
<tr>
<td>-5</td><td>Missing; Unknown</td>
<tr>
<tr>
<td>-4</td><td>Not asked</td>
<tr>
<tr>
<td>-3</td><td>Not applicable</td>
<tr>
<tr>
<td>-2</td><td>No answer</td>
<tr>
<tr>
<td>-1</td><td>Don't know'</td>
<tr>
<tr>
<td>1</td><td>yes</td>
<tr>
<tr>
<td>0</td><td>no</td>
<tr>
</table>
</br>

I'm focusing only in the `yes` or `no` values, or in `yes` in particular.






The data is not provided in any generic for but only in proprietary SAS/SPSS/Stata format, but using **foreign**-package it is doable. (a .csv or .Rdata would perhaps be a good idea in these days!)




{% highlight r %}
library(foreign)
# Load the oridinal dataset into R
datB <- read.dta("~/workspace/data/wvs/wvs2005_v20090901b.dta")
datA <- read.dta("~/workspace/data/wvs/wvs2005_v20090901a.dta")
# Create proportional tables from both data by country there are some issues
# with country labels so I convert the variable into a string
datA$v2 <- as.character(datA$v2)
datB$v2 <- as.character(datB$v2)
# Create unweighted proportional tables from both datas
tblA <- as.data.frame(prop.table(table(datA$v2, datA$v75), 1) * 100)
tblB <- as.data.frame(prop.table(table(datB$v2, datB$v75), 1) * 100)
# Combine the tables
tbl <- rbind(tblA, tblB)
# subset the tables to include only ues or no options
tbl2 <- tbl[tbl$Var2 %in% c("yes", "no"), ]
tbl2$Var2 <- factor(tbl2$Var2, levels = c("yes", "no"))
{% endhighlight %}


## Distribution of answers by country as histogram


{% highlight r %}
## To nicely order the plot I will melt the data into wide format, reorder it
## and convert it back to long format for plotting
library(reshape2)
orderDat <- dcast(tbl2, Var1 ~ Var2, value.var = "Freq")
orderDat$Var1 <- reorder(orderDat$Var1, orderDat$yes, median)
tblPlot <- melt(orderDat, id.vars = "Var1", measure.vars = c("yes", "no"))
# And then the plot relevelling the levels to match the daulft colors better
tblPlot$variable <- factor(tblPlot$variable, levels = c("no", "yes"))
library(ggplot2)
ggplot(tblPlot, aes(x = Var1, y = value, fill = variable)) + geom_bar(stat = "identity") + 
    coord_flip() + theme(legend.position = "top") + theme(axis.text.x = element_text(size = 14), 
    axis.text.y = element_text(size = 14), legend.text = element_text(size = 14))
{% endhighlight %}

![center](/figs/2013-11-14-world-values-survey-on-map/wvsBarplot.png) 


## Plotting the data on the map

### Downloading the geographical data

Here I'm downloading the whole world shapefile from [www-mappinghacks.com](http://www-mappinghacks.com). Of course there are many more options if available, but I picked it as it small size file but it still has the details needed. (I'm a novice in using world levels shapefiles fo please let me know of better resources).

I greatly recommend you to familiarize yourself with theoretical literature of spatial reasoning in social sciences for example by reading [*Lobao, Linda M., Gregory Hooks, ja Ann R. Tickamyer. The Sociology of Spatial Inequality. State University of New York Press, 2007.*](http://books.google.ru/books/about/The_Sociology_of_Spatial_Inequality.html?id=67P6jXQ05LAC&redir_esc=y) as well as with open source ecosystem for geographics information systems through [Bivand, Roger S., Edzer J. Pebesma, ja Virgilio Gómez-Rubio. Applied Spatial Data Analysis with R. 2. p. Springer, 2013.](http://www.asdar-book.org/). [CRAN Task View: Analysis of Spatial Data](http://cran.r-project.org/web/views/Spatial.html) is a crucial resources if you want to push this approach further in your analysis. 



{% highlight r %}
download.file("http://www.mappinghacks.com/data/TM_WORLD_BORDERS-0.2.zip", destfile = "NUTS_2010_60M_SH.zip")
# unzip to SpatialPolygonsDataFrame
unzip("NUTS_2010_60M_SH.zip")
library(rgdal)
shape <- readOGR(dsn = "./", layer = "TM_WORLD_BORDERS-0.2")
{% endhighlight %}




{% highlight r %}
# download.file('http://www.mappinghacks.com/data/TM_WORLD_BORDERS-0.2.zip',
# destfile = 'NUTS_2010_60M_SH.zip') # unzip to SpatialPolygonsDataFrame
# unzip('NUTS_2010_60M_SH.zip')
library(rgdal)
# shape <- readOGR(dsn = './', layer = 'TM_WORLD_BORDERS-0.2')
shape <- readOGR(dsn = "/home/aurelius/workspace/data/shapefiles/world/TM_WORLD_BORDERS_SIMPL-0.3/", 
    layer = "TM_WORLD_BORDERS_SIMPL-0.3")
{% endhighlight %}



{% highlight text %}
## OGR data source with driver: ESRI Shapefile 
## Source: "/home/aurelius/workspace/data/shapefiles/world/TM_WORLD_BORDERS_SIMPL-0.3/", layer: "TM_WORLD_BORDERS_SIMPL-0.3"
## with 246 features and 11 fields
## Feature type: wkbPolygon with 2 dimensions
{% endhighlight %}


### Converting the shape into data.frame and merging the attribute data with it

I'm taking a bit of a shortcut here as I'm converting the `SpatialPolygonDataFrame` right away into regular `data.frame` using `fortify`-function from **ggplot2**.

Thereafter I will merge the `yes` values from the WVS data summary. This merging is often problematic due to mismatch in the country names in different datasets. In this example I'm only changing the first letters of countrynames from WVS into uppercase and hope that match will happen. Most probably you would need to create a key table for perfect match.



{% highlight r %}
# fortify the data
library(ggplot2)
shape$id <- rownames(shape@data)
map.points <- fortify(shape, region = "id")
map.df <- merge(map.points, shape, by = "id")
# subset only the yeas options
yesDat <- tblPlot[tblPlot$variable == "yes", ]
# Function the uppercase the first characters
.simpleCap <- function(x) {
    s <- strsplit(x, " ")[[1]]
    paste(toupper(substring(s, 1, 1)), substring(s, 2), sep = "", collapse = " ")
}
yesDat$Var1 <- as.character(yesDat$Var1)
yesDat$Var1C <- sapply(yesDat$Var1, .simpleCap)
# merge the datas using country names
map.df <- merge(map.df, yesDat, by.x = "NAME", by.y = "Var1C", all.x = TRUE)
# order the data for smooth plotting
map.df <- map.df[order(map.df$order), ]
{% endhighlight %}


### A whole world using mercator projetion


{% highlight r %}
library(ggplot2)
ggplot(map.df, aes(long,lat,group=group)) +
  geom_polygon(aes(fill=value)) +
  geom_polygon(data = map.df, aes(long,lat), 
               fill=NA, 
               color = "white",
               size=0.1) + # white borders
  scale_fill_gradient2(low="white", high="blue")+
    theme(legend.position="top")
{% endhighlight %}

![center](/figs/2013-11-14-world-values-survey-on-map/wvsMercator.png) 


### Using Orthographic projection centered at Moscow



{% highlight r %}
library(ggplot2)
ggplot(map.df, aes(long,lat,group=group)) +
  geom_polygon(aes(fill=value)) +
  geom_polygon(data = map.df, aes(long,lat), 
               fill=NA, 
               color = "white",
               size=0.1) + # white borders
  scale_fill_gradient2(low="white", high="blue")+
    theme(legend.position="top") +
    coord_map("ortho", orientation=c(55, 37, 0))
{% endhighlight %}

![center](/figs/2013-11-14-world-values-survey-on-map/wvsOrtho.png) 


The grey stands for missing data that covers most of the countries. That is due to both missing data in VWS 2005 and errors in merging the attribute data with the shape. Also, the issue of spatial story behind the scandinavians willingness to fight wars did not become much clearer as a results of this one hour exercise.





[jekyll-gh]: https://github.com/mojombo/jekyll
[jekyll]:    http://jekyllrb.com
