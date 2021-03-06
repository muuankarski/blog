---
layout: post
title:  "Toistettava analyysi knitr:n ja pandoc:n avulla R:ssä"
date:   2013-03-02 12:00:00
categories: open science
---

## Taustaa
Pidin pari viikkoa sitten Turun yliopistolla työpajan otsakkeella [Oikopolkua datasta julkaisuun - Toistettava data-analyysiprosessi määrällisessä sosiaalitutkimuksessa R:n, Markdownin ja knitr:n avulla](http://markuskainu.fi/workshop/toistettava/). Työpajassa rakensimme toistettavan data-analyysiprosessin yhteiskuntatieteelliselle survey-tutkimukselle tyypilliseen asetelmaan. Survey-aineistona käytimme [Life in Transition survey II](http://www.ebrd.com/pages/research/publications/special/transitionII.shtml):sta vuodelta 2010 sekä maatason datana Göteborgin yliopiston )[The Quality of Government Instituten](http://www.qog.pol.gu.se/ datasta erilaista maatason indikaattoreista liittyen maan vaurauteen, demokratiaan, korruptioon sekä kansalaisten elinoloihin. Kaikki yllä olevat aineistot ovat *oikeita* aineistoja ja avoimesti käytettävissä.

Työpajan tavoitteena oli:


- Antaa osallistujalle taidot omien tutkimusten data-analyysin suunnitteluun ja toteuttamiseen toistettavuuden näkökulmasta.
- Tehdä tutuksi uusimpia R-kielen sovelluksia data-analyysiin hallintaan
- Tehdä tutuksi erilaisia teknolgioita tulosten sähköiseen julkaisemiseen.

## Mistä on kyse

Tässä blogipostauksessa esittelen tiivistettynä yhden vaihtoehdon toistettavaan työvirtaan, jonka tulokset on mahdollista julkaista perinteisinä toimisto-ohjelmien (MS Word, LibreOffice Writer) formaateissa, latex-pdf:nä sekä sähköisinä formaatteina **html** ja **.epub** -formaateissa. (epub-formaattia ei käsitellä tässä. Lue täältä lisää: [Creating an ebook with pandoc](http://johnmacfarlane.net/pandoc/epub.html))

## Ohjelmistoympäristö ja jutun juju

Laskennalliset analyysit tehdään [R-kiellä](http://www.r-project.org/), jota käytetään [RStudio](http://www.rstudio.com/ide/)-käyttöliittymästä käsin. Asiakirja kirjoitetaan [Markdown](http://daringfireball.net/projects/markdown/)-merkintäkieleen pohjautuvaa [R Markdownia](http://www.rstudio.com/ide/docs/authoring/using_markdown) käyttäen. R Markdown on siis yhdistelmä Markdown kielellä merkittyä tekstiä, jonka väliin on sijoitettu R-koodin *kimpaleita*.

Tämä R-markdown dokumentti *kudotaan* [knitr](http://yihui.name/knitr/)-paketin avulla tavanomaiseksi markdown-dokumentiksi. Knitr siis ajaa r-analyysit ja sijoittaa halutut analyysien tulosteet haluttuihin paikkoihin. Alla oleva demo on vain hyvin yksinkertainen esimerkki siitä, miten analyysi on mahdollista kirjoittaa.

Markdown-muotoisen asiakirjan luomisen jälkeen peliin tulee käsittämätön [pandoc](http://johnmacfarlane.net/pandoc/)-asiakirjan kääntäjä. Berkeleyn yliopiston filosofian professorin [John MacFarlanen](http://johnmacfarlane.net/) kehittämä ohjelma kääntää asiakirjoja eri formaattien välillä ja on erityisen kyvykän akateemisten tutkimusraporttien erityisvaatimusten kanssa. Pandocin avulla huolella laadittu R Markdown muotoinen analyysi on mahdollista kääntää käytännössä mihin tahansa muotoon, tietyin varauksin.

## Ohjelmistoympäristön asentaminen

Mikäli haluat koko pandocin voiman käyttöön, niin tarvitset myös tex-asennuksen. Toisin sanoen seuraavan demon läpiajoon pitää asennettuna olla R, RStudio sekä pandoc sekä latex. Seuraavassa ohjeet miten se tapahtuu eri käyttöjärjestelmiin:

- [R-ohjelman asentaminen](http://ftp.sunet.se/pub/lang/CRAN/) - latauksen ja asennuksen kesto n. 60s.
- [RStudion asentaminen](http://www.rstudio.com/ide/download/) - latauksen ja asennuksen kesto n. 60s.
- [Pandoc:in asentaminen](http://johnmacfarlane.net/pandoc/installing.html) - latauksen ja asennuksen kesto n. 30s.
- [Latex:in asentaminen linuxiin, Mac OS X:ään ja Windowsiin](http://www.latex-project.org/ftp.html) - latauksen ja asennuksen kesto n. 60 min.

R:ssä tulee lisäksi olla asennettuna paketit:

install.packages("ggplot2") 
install.packages("reshape2")
install.packages("knitr")
install.packages("markdown")
install.packages("devtools")

## Demoasiakirja 

Demossa käytettävät tiedostot löytyvät zipattuna seuraavasta linkistä: [toistettava_pandoc.zip](http://markuskainu.fi/material/blog/toistettava/toistettava_pandoc.zip)

Kansio pitää sisällään seuraavat neljä tiedostoa:

- [**file1.Rmd** - Pelkistetty R Markdown muotoinen asiakirja](http://markuskainu.fi/material/blog/toistettava/file1.Rmd)
- [**file2.Rmd** - Sama asiakirja “akateemisin lisämaustein”](http://markuskainu.fi/material/blog/toistettava/file2.Rmd)
    - otsikkolohko pandoc-tyyliin
    - lähdeviitteet pandoc-tyyliin
    - abstrakti
- [**bibtex.bib** - muutama viite bibtex.muodossa](http://markuskainu.fi/material/blog/toistettava/bibtex.bib)
- [**article.css** - css-tyylitiedosto html-muotoiselle asiakirjalle](http://markuskainu.fi/material/blog/toistettava/article.css)

Alla oleva video näyttää, miten voit luoda erimuotoiset asiakirja alkuperäistiedostoista. Videon alapuolella on molemmat .Rmd asiakirjojen koodit upotettuna.

### Video

<iframe src="http://player.vimeo.com/video/60892384" width="500" height="282" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe> <p><a href="http://vimeo.com/60892384">Toistettava analyysi knitr:n ja pandoc:n avulla R:ssä</a> from <a href="http://vimeo.com/user2534934">Markus Kainu</a> on <a href="https://vimeo.com">Vimeo</a>.</p>

## Valmiit asiakirjat

### File1


- [pdf](http://markuskainu.fi/material/blog/toistettava/file1.pdf)
- [html](http://markuskainu.fi/material/blog/toistettava/file1.html)
- [odt](http://markuskainu.fi/material/blog/toistettava/file1.odt)
- [docx](http://markuskainu.fi/material/blog/toistettava/file1.docx)

### File2

- [pdf](http://markuskainu.fi/material/blog/toistettava/file2.pdf)
- [html](http://markuskainu.fi/material/blog/toistettava/file2.html)
- [odt](http://markuskainu.fi/material/blog/toistettava/file2.odt)
- [docx](http://markuskainu.fi/material/blog/toistettava/file2.docx)

[jekyll-gh]: https://github.com/mojombo/jekyll
[jekyll]:    http://jekyllrb.com
