#!/usr/bin/Rscript

setwd("~/workspace/web/site_markuskainufi/rqog")
library(kaRski)
# knit examples
knitpandoc("index")
system("pandoc --section-divs -t html5 -s --template rqog.template -o index.html index.md")

