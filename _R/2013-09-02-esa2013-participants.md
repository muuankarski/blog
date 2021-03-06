---
layout: post
title:  "ESA2013-conference - Where did the scholars come from?"
date:   2013-09-03 18:13:45
categories: R-project
---


I went to Turin in Italy last week for the annual conference of European Sociological Association. It was my first time in this event and I was surprised by the extend of it. I flew home last night and though it would be interesting to see which universities and which geographical regions were best represented in the conference. Based on walking and talking for few days I was expecting Finns to do rather well. On the other hand, as the conference was themed around the current *crises* I was assuming that scholars from crises ridden countries would be around in numbers to discuss some real issues in their societies.

Without thinking too much I decided to

1. count the participants by each university and create a histogram of the most well represented one and 
2. geocode those universities and visualize them to see if there are any East-West or South-North issues in it.

As this post aims to show who were participating at ESA2013, but also how to run such simple analysis in R, I'm leaving the code there. You can copy-paste it to your R-console and it should work with the required packages installed.  

## Parsing the data

As for **data** I use the up-to-date conference program at [http://www.esa11thconference.eu/programme](http://www.esa11thconference.eu/programme). It is obvious from the html code of the website the program is presented in one large html-table. Therefore I may apply `readHTMLtable`-function from **XML**-package  to extract the participants with their universities and titles of their presentations.



```r
library(XML)
url <- "http://www.esa11thconference.eu/programme"
x <- readHTMLTable(url, header = FALSE)
x <- x[[1]]
whole.program <- as.character(x$V1)
head(whole.program, 3)
```

```
## [1] "PS Plenary Sessions"                                                                                                                                                                              
## [2] "28/8 17:30 - 20:00 - Piazza Castello, Teatro Regio\r\n                            01PS - Opening Plenary: Crisis and Critique"                                                                    
## [3] "ESA-4838 Finance in Crisis - the neglected critique of money\n                                ORAL PRESENTATION\r\n                                Mary Mellor, Northumbria University, Newcastle"
```


You could participate in three waysm, with

1. an oral presentation,
2. a poster, or 
3. a distributed paper

For this analysis I need only the university/institution from each presentations, so extracting only that information using *regular expressions*. **Some papers were collaborative works with multiple authors, but my analysis will only include the affliation of the author listed last in the program. This may cause significant bias in the results.**

However, below we can see the top six universities in all three categories.

**I did a rough manual check to see if there are some universities missing due to misspelling etc. Higher schoolf of Economics from Moscow was written in three different ways and edited the names a bit to for them to merge**


```r
oral <- grep("ORAL PRESENTATION", whole.program, value = TRUE)
poster <- grep("POSTER", whole.program, value = TRUE)
distributed <- grep("DISTRIBUTED PAPER", whole.program, value = TRUE)
library(stringr)
## ORAL PRESENTATION
oral <- str_extract(oral, "((\r\n))+.*")
oral <- str_replace_all(oral, "(\r\n)+ *", "")
oral <- str_replace_all(oral, ".*, ", "")
## harminising HSE moscow
oral <- str_replace_all(oral, "\"", "")
oral <- str_replace_all(oral, "- ", "")
## 
oral.df <- as.data.frame(table(oral))
names(oral.df) <- c("University", "Freq")
head(oral.df[order(-oral.df$Freq), ])
```

```
##                 University Freq
## 791 University of Helsinki   41
## 916    University of Turin   40
## 929   University of Warsaw   36
## 212       Ghent University   29
## 346                 Lisbon   25
## 350                 London   25
```

```r
## POSTER
poster <- str_extract(poster, "((\r\n))+.*")
poster <- str_replace_all(poster, "(\r\n)+ *", "")
poster <- str_replace_all(poster, ".*, ", "")
## harminising HSE moscow
poster <- str_replace_all(poster, "\"", "")
poster <- str_replace_all(poster, "- ", "")
poster.df <- as.data.frame(table(poster))
names(poster.df) <- c("University", "Freq")
head(poster.df[order(-poster.df$Freq), ])
```

```
##                 University Freq
## 19 Kurgan State University    3
## 25                  Moscow    3
## 8                   Cracow    2
## 50   University of Bologna    2
## 63     University of Tartu    2
## 1        Aarhus University    1
```

```r
## DISTRIBUTED
distributed <- str_extract(distributed, "((\r\n))+.*")
distributed <- str_replace_all(distributed, "(\r\n)+ *", "")
distributed <- str_replace_all(distributed, ".*, ", "")
## harminising HSE moscow
distributed <- str_replace_all(distributed, "\"", "")
distributed <- str_replace_all(distributed, "- ", "")
distributed.df <- as.data.frame(table(distributed))
names(distributed.df) <- c("University", "Freq")
head(distributed.df[order(-distributed.df$Freq), ])
```

```
##                                 University Freq
## 45                  University of Helsinki    4
## 22                                  Moscow    3
## 27 St. Petersburg State Medical University    3
## 47                  University of Lausanne    3
## 16                 Kore University of Enna    2
## 1                                  Antalya    1
```


As both, the *poster* and the *distributed paper* category are small, I will merge them to the *oral presentation* category.


```r
esa.data <- rbind(oral.df, poster.df, distributed.df)
```




## Which universities were best represented at conference?

As we now have our data formatted, we can plot the universities that had a team of ten or more scholars participating the conference.


```r
plot.df <- esa.data[order(-esa.data$Freq), ]
plot.df <- plot.df[plot.df$Freq >= 10, ]
# add ranking numbers to university names
plot.df$rank <- rank(-plot.df$Freq)
plot.df$RankUniversity <- paste(plot.df$rank, plot.df$University, sep = " ")
# order the data
order <- plot.df[order(plot.df$Freq), ]
plot.df$RankUniversity <- factor(plot.df$RankUniversity, levels = order$RankUniversity)
# Plot the histogram
library(ggplot2)
ggplot(plot.df, aes(x = RankUniversity, y = Freq, label = Freq)) + geom_bar(stat = "identity", 
    position = "dodge") + geom_text(hjust = -0.2, size = 3) + coord_flip() + 
    theme_minimal()
```

![plot of chunk plot1](figure/plot1.png) 


What caught my eye first is the strong presence of Finnish universities on the list. Helsinki at the top and four others in top 33. Not surprisingly, Italian Universities are well represented, too.

## Where are those universities located?

To get a better understanding of which parts oh the Europe were represented at the conference it may be useful to plot the universities on map. 

First, we have to geocode the universities. I'm using Google maps here and the `geocode`from **ggmap**-package. (Note that in most cases by using this function you are agreeing to the Google Maps API Terms of Service at [https://developers.google.com/maps/terms](https://developers.google.com/maps/terms))



```r
library(ggmap)
location <- as.character(plot.df$University)
code <- geocode(location, output = c("latlon", "latlona", "more", "all"), messaging = FALSE, 
    sensor = FALSE, override_limit = FALSE)
spat.data <- cbind(location, code)
plot.df2 <- merge(plot.df, spat.data, by.x = "University", by.y = "location")
head(plot.df2, 3)
```

```
##                   University Freq rank      lon   lat
## 1                    11 Oslo   19   11    4.510 51.85
## 2               11 Rotterdam   19   11    4.474 51.90
## 3 11 University of Barcelona   19   11 -117.820 33.67
```


Second, we shall download a detailed *shapefile* of Europe from [gisco](http://epp.eurostat.ec.europa.eu/portal/page/portal/gisco_Geographical_information_maps/popups/references/administrative_units_statistical_units_1) at the scale of 1:60 million, fortify it into `data.frame` and merge our data on university locations with it. This part follows my example from here: [Spatial visualisation of Eurostat Regional Data](http://markuskainu.fi/r-tutorial/eurostat/spatial.html)


```r
download.file("http://epp.eurostat.ec.europa.eu/cache/GISCO/geodatafiles/NUTS_2010_60M_SH.zip", 
    destfile = "NUTS_2010_60M_SH.zip")
# unzip to SpatialPolygonsDataFrame
unzip("NUTS_2010_60M_SH.zip")
library(rgdal)
map <- readOGR(dsn = "./NUTS_2010_60M_SH/data", layer = "NUTS_RG_60M_2010")
```

```
## OGR data source with driver: ESRI Shapefile 
## Source: "./NUTS_2010_60M_SH/data", layer: "NUTS_RG_60M_2010"
## with 1920 features and 4 fields
## Feature type: wkbPolygon with 2 dimensions
```

```r
map <- subset(map, STAT_LEVL_ <= 0)
library(ggplot2)
library(rgeos)
map$id <- rownames(map@data)
map.points <- fortify(map, region = "id")
map.df <- merge(map.points, map, by = "id")
# 
```


And then we shall plot the map.


```r
library(ggplot2)
# plot faceted by year
ggplot(map.df, aes(long,lat,group=group)) +
  geom_polygon(data = map.df, aes(long,lat), 
               fill=NA, 
               color = "grey80",
               size=0.5) + # white borders
  geom_point(data = plot.df2, aes(x=lon,
                                  y=lat,
                                  group=University,
                                  size=Freq), 
               color = "blue", alpha=.8,shape=1) + 
  coord_map(project="orthographic", xlim=c(-22,34),
              ylim=c(35,70)) + # projection
  theme_minimal()
```

![plot of chunk mapplot1](figure/mapplot1.png) 


Spatial view gives perhaps a better view to see which regions/countries we represented and which we not. There seems to be conventration by Gulf of Finland (Estonia & Finland), in Poland and on both sides of English Channel in addition to Italy. 


```r
library(ggplot2)
# plot faceted by year
ggplot(map.df, aes(long,lat,group=group)) +
  geom_polygon(data = map.df, aes(long,lat), 
               fill=NA, 
               color = "grey80",
               size=0.5) + # white borders
  geom_point(data = plot.df2, aes(x=lon,
                                  y=lat,
                                  group=University,
                                  size=Freq), 
               color = "blue", alpha=.8,shape=1) +  
  geom_text(data = plot.df2, aes(x=lon,
                                  y=lat,
                                 label=University, 
                                 group=University),
            size=3.5,vjust=-1,color="dim grey") + 
  coord_map(project="orthographic", xlim=c(-22,34),
              ylim=c(35,70)) + # projection
  theme_minimal()
```

![plot of chunk mapplot2](figure/mapplot2.png) 


Sure, some of the readers will say that we had several universities with nine scholars attending, let say from Germany. As a final plot, I have included all the paper and geocoded them on the map below. Each dot represents one presentation, poster or distributed paper. (this takes some processing time from Google)


```r
library(stringr)

whole <- grep("ORAL PRESENTATION|POSTER|DISTRIBUTED PAPER", whole.program, value = TRUE)
## WHOLE PROGRAM
whole <- str_extract(whole, "((\r\n))+.*")
whole <- str_replace_all(whole, "(\r\n)+ *", "")
whole <- str_replace_all(whole, ".*, ", "")
## harminising HSE moscow
whole <- str_replace_all(whole, "\"", "")
whole <- str_replace_all(whole, "- ", "")
whole <- whole[1:100]
## geocoding each individual paper Extracting unique locations and geocode
## them
uniq <- unique(whole)
library(ggmap)
coord <- geocode(uniq, output = c("latlon", "latlona", "more", "all"), messaging = FALSE, 
    sensor = FALSE, override_limit = FALSE)
spat.data <- cbind(uniq, coord)
whole.df <- as.data.frame(whole)
plot.df3 <- merge(whole.df, spat.data, by.x = "whole", by.y = "uniq")
```


And then we will map it


```r
library(ggplot2)
# plot faceted by year
ggplot(map.df, aes(long,lat,group=group)) +
  geom_polygon(data = map.df, aes(long,lat), 
               fill=NA, 
               color = "grey80",
               size=0.5) + # white borders
  geom_point(data = plot.df3, aes(x=lon,
                                  y=lat,
                                  group=whole), 
               color = "blue", alpha=.8, size=2,shape=1,
             position=position_jitter(width=.1,height=.1)) + 
  coord_map(project="orthographic", xlim=c(-15,34),
              ylim=c(35,70)) + # projection
  theme_minimal()
```

![plot of chunk mapplot3](figure/mapplot3.png) 



## Conclusions

Eventhough the conference was themed after the current crisis, scholars from the most crises ridden countries were missing from the conference. This may well be one of the consequences of crisis or just pure coincidence. 

Finnish scholars seem to well in this comparison. Whether it is the well-budgeted travel funds or just high ambition to contribute at the international level, I don't know. However, interaction with other European scholars is a thing to embrace.




[jekyll-gh]: https://github.com/mojombo/jekyll
[jekyll]:    http://jekyllrb.com
