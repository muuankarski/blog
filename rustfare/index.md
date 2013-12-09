## Main

**rustfare**: *toolbox for R language for open welfare data from Russian Federation*

This site has examples on how to use rustfare-package and up-to-date package-documentation, same as delivered with the package itself. Click here for [rustfare on Github](https://github.com/rOpenGov/rustfare).

## rustfare-package

- The rustfare package pools together tools for searching, extracting, and formatting welfare data on Russian Federation from different data providers. 
- The rustfare functions are named according to data provider or the data set. 
- Currently there is data available from: 
    - Rosstat Regional Statistics, 
    - OECD, 
    - Quality of Governance -institute and
    - GADM database of Global Administrative Areas. 
    - World Bank World Development Indicators on Russian Federation can be accessed using [WDI-package](http://cran.r-project.org/web/packages/WDI/index.html) (for examples, see: [markuskainu.fi/r-tutorial/wb/](http://markuskainu.fi/r-tutorial/wb/)

## To-do list (20131115)
- Change the source of Rosstat raw data from [Rosstat Regional statistics](http://www.gks.ru/wps/wcm/connect/rosstat_main/rosstat/ru/statistics/publications/catalog/doc_1138623506156) to [fedstat.ru](http://fedstat.ru/indicators/start.do) and [hub.opengovdata.ru](http://hub.opengovdata.ru/).
- To incorporate [census data from 2002](http://std.gmcrosstata.ru/webapi/opendatabase?id=vpn2002_pert) and [election data from duma election 2011](http://www.vybory.izbirkom.ru/region/region/izbirkom?action=show&root=1&tvd=100100028713304&vrn=100100028713299&region=0&global=1&sub_region=0&prver=0&pronetvd=null&vibid=100100028713304&type=233) with the package

## Installation


```r
library(devtools)
install_github(repo = "rustfare", username = "rOpenGov")
library(rustfare)
```


## Examples by data source

Examples                                             Link to Data Source                                                                                                                                                   Shiny apps
-------------------------------------------          --------------------------------------------------------------------------------------------------------------------------------------------------------------------- -------------
[Rosstat Regional Statistics](example_rosstat.html)  [Регионы России. Социально-экономические показатели](http://www.gks.ru/wps/wcm/connect/rosstat_main/rosstat/ru/statistics/publications/catalog/doc_1138623506156)     [rustfare-shiny](http://glimmer.rstudio.com/muuankarski/rustfare/)
[Quality of Governance](example_qog.html)            [The Quality of Governance Institute (University of Gothernburg](http://www.qog.pol.gu.se/)
[Oecd](example_oecd.html)                            [Country statistical profile: Russian Federation](http://www.oecd-ilibrary.org/economics/country-statistical-profile-russian-federation-2013_csp-rus-table-2013-1-en)
[Spatial operations on GADM data](example_gadm.html) [Global Administrative Areas (GADM)](http://www.gadm.org/)                



## Documentation by function

Automatically generated from package documentation .Rd files in [https://github.com/muuankarski/rustfare/tree/master/man](https://github.com/muuankarski/rustfare/tree/master/man)


<table width="100%">
<tr><th>Name</th><th>Functionality</th></tr>

<tr><td width="25%"><a href="rustfare.html">rustfare-package</a></td>
<td>rustfare: toolbox for R language for open welfare data from Russian Federation</td></tr>
<tr><td width="25%"><a href="GetOecd.html">GetOecd</a></td>
<td>Download data from OECD Country statistical profile: Russian Federation</td></tr>
<tr><td width="25%"><a href="GetQog.html">GetQog</a></td>
<td>Download data from Quality of Governance data</td></tr>
<tr><td width="25%"><a href="GetRosstat.html">GetRosstat</a></td>
<td>Download data from Rosstat Regional Statistics</td></tr>
<tr><td width="25%"><a href="GetRusGADM.html">GetRusGADM</a></td>
<td>Get Russian map data in GADM format</td></tr>
<tr><td width="25%"><a href="IndicatorOecd.html">IndicatorOecd</a></td>
<td>List the currently available indicators from OECD Country statistical profile</td></tr>
<tr><td width="25%"><a href="IndicatorQog.html">IndicatorQog</a></td>
<td>List the currently available indicators from Quality of Governance database</td></tr>
<tr><td width="25%"><a href="IndicatorRosstat.html">IndicatorRosstat</a></td>
<td>List the currently available indicators from Rosstat Regional Statistics</td></tr>
<tr><td width="25%"><a href="RosstatMapPlot.html">RosstatMapPlot</a></td>
<td>Print map using ggplot2</td></tr>
<tr><td width="25%"><a href="rustfare.html">rustfare</a></td>
<td>rustfare: toolbox for R language for open welfare data from Russian Federation</td></tr>
<tr><td width="25%"><a href="ScrapeData.html">ScrapeData</a></td>
<td>Scrape the raw html-table data</td></tr>
<tr><td width="25%"><a href="ScrapeData_skip1.html">ScrapeData_skip1</a></td>
<td>Scrape the raw html-table data (skipping the 1st row)</td></tr>


</table>


---

<center>
&copy; Markus Kainu 2013
</center>


