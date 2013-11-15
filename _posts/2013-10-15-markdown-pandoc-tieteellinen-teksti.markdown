---
layout: post
title:  "Markdown ja pandoc - tekstipohjaisen tieteellisen kirjoittamisen työvirta"
date:   2013-10-15 10:53:45
categories: tools
---

Tässä kirjoituksessa esitellään tekstipohjainen työvirta digitaalisten tekstien kirjoittajalle, joka haluaa tehdä yksinkertaiset asiat yksinkertaisesti ja keskittyä monimutkaisten asioiden monimutkaisuuteen.

## Digitaalisuus ja MS Wordin kuolema

Skottilaisen scifi-kirjailijan Charles Strossin lauantaina julkaisema blogiposti *[Why Microsoft Word must Die](http://www.antipope.org/charlie/blog-static/2013/10/why-microsoft-word-must-die.html)* on herättänyt vilkasta keskustelua blogin kommenttiosiossa, ja tekstiä on jaettu ahkerasti sosiaalisessa mediassa viime päivinä. Stross on läpensä kyllästynyt Microsoftin tekstinkäsittelyohjelman yleiseen epätarkoituksenmukaisuuteen, tekniseen takapajuisuuteen sekä ansaitsemattomaan valta-asemaan ja haluaa sen kuolevan.

>Microsoft Word is a tyrant of the imagination, a petty, unimaginative, inconsistent dictator that is ill-suited to any creative writer's use. Worse: it is a near-monopolist, dominating the word processing field. Its pervasive near-monopoly status has brainwashed software developers to such an extent that few can imagine a word processing tool that exists as anything other than as a shallow imitation of the Redmond Behemoth. But what exactly is wrong with it?

Stross kirjoittaa ansiokkaasti siitä, mikä kaikki ohjelmassa on vialla kirjoja kirjoittavan ammattilaisen näkökulmasta. Tieteellisen kirjoittamisen näkökulmasta MS Wordissä on vialla huomattavasti useampi seikka kuin mihin Stross puuttuu, mutta silti sillä on yhä vankka asema myös tieteellisen kirjoittamisessa.

Wordin suosion ja kelvottomuuden ydin on sen **WYSIWYG**, eli *What You See Is What You Get* (mitä näet, sitä saat) -tyyppinen käyttöliittymä. Useat ihmiset haluavat edelleen hahmottaa tekstinsä vasten valkoista A4-koodin paperia, vaikka yhä useampi teksti julkaistaan vain digitaalisessa muodossa (blogi,e-kirja,www-sivu, tms.) tai se tullaan taittamaan uudelleen ennen paperille tulostamista. Tämä on tietysti seurausta laajemmasta tiedonvälityksen digitalisoitumisesta, jota ei ole tarpeen tässä laajemmin käsitella kuin vain todeta että **MS Wordin *What You See Is What You Get* -lupaus pitää paikkansa koko ajan yhä harvemmin**. Kirjoittajat tuottavat tekstejä yhä laajemmalle kirjolle julkaisualustoja, mikä tarkoittanee MS Wordille nopeaa kuolemaa ja siihen luottaville kirjoittajille lisääntyviä ongelmia. 

## Lähdekoodiajattelu tieteellisessä kirjoittamisessa

Tämä blogipäivitys valmistaa lukijaansa Wordin kuolemaan esittelemällä nokkelan lähestymistavan digitaaliseen kirjoittamiseen. (mikäli kirjoitat käsin tai mekaanisella kirjoituskoneella et tule hyötymään tästä) Kutsun sitä *lähdekoodiajatteluksi kirjoittamisessa* ja ajattelun ydin on siinä, että **kirjoittaja laatii tekstistä *tekstimuotoisen lähdekoodin*, joka käännetään kulloinkin tarvittavaan asiakirjaformaattiin**. Tässä esimerkissä teksti kirjoitetaan [markdown](http://daringfireball.net/projects/markdown/)-merkintäkielellä ja käännetään [pandoc](http://johnmacfarlane.net/pandoc/README.html)-dokumentinkääntäjällä haluttuun julkaisuformaattiin, joka voi olla esim: 

- HTML formaatit: XHTML, HTML5, ja HTML esitysgrafiikka käyttäen
    [Slidy](http://www.w3.org/Talks/Tools/Slidy),
    [reveal.js](http://lab.hakim.se/reveal-js/),
    [Slideous](http://goessner.net/articles/slideous/),
    [S5](http://meyerweb.com/eric/tools/s5/), tai
    [DZSlides](http://paulrouget.com/dzslides/).
- Tekstinkäsittelyohjelmien formaatit: Microsoft Word
    [docx](http://www.microsoft.com/interop/openup/openxml/default.aspx),
    OpenOffice/LibreOffice
    [ODT](http://en.wikipedia.org/wiki/OpenDocument), [OpenDocument
    XML](http://opendocument.xml.org/)
- E-kirjat: [EPUB](http://en.wikipedia.org/wiki/EPUB) version 2 or 3,
    [FictionBook2](http://www.fictionbook.org/index.php/Eng:XML_Schema_Fictionbook_2.1)
-  Dokumentaatio-formaatit: [DocBook](http://www.docbook.org/), [GNU
    TexInfo](http://www.gnu.org/software/texinfo/), [Groff
    man](http://www.gnu.org/software/groff/groff.html) pages, [Haddock
    markup](http://www.haskell.org/haddock/doc/html/ch03s08.html)
- Outline-formaatit: [OPML](http://dev.opml.org/spec2.html)
- TeX-formaatit: [LaTeX](http://www.latex-project.org/),
    [ConTeXt](http://www.pragma-ade.nl/), LaTeX Beamer esitysgrafiikka
- [PDF](http://en.wikipedia.org/wiki/Portable_Document_Format) via
    LaTeX
- Kevyet merkintäkielet:
    [Markdown](http://daringfireball.net/projects/markdown/),
    [reStructuredText](http://docutils.sourceforge.net/docs/ref/rst/introduction.html),
    [AsciiDoc](http://www.methods.co.nz/asciidoc/), [MediaWiki
    markup](http://www.mediawiki.org/wiki/Help:Formatting), Emacs
    [Org-Mode](http://orgmode.org),
    [Textile](http://redcloth.org/textile)
- Kustomoidut formaatit: [lua](http://www.lua.org).

Kun tekstistä on olemassa *tekstimuotoinen lähdekoodi* täytyy kirjoittajan ylläpitää vain tätä yhtä tekstiä ja kaikki muut formaatit on käännettävissä tästä lähteestä tarpeen mukaan. Tekstimuotoinen lähdekoodi luo puitteet myös kunnollisen versionhallinnan, kuten [git](http://linux.fi/wiki/Git):in käytölle. Sillä on myös monia muita etuja, joista kenties myöhemmissä kirjoituksissa lisää.

## Tekstipohjaisen kirjoittamisen ohjelmistoympäristö

Tekstin kirjoittamiseen tietokoneella vaaditaan vain [tekstieditori](http://fi.wikipedia.org/wiki/Tekstieditori), joista *muistio/notepad* lienee Windows-käyttäjille tutuin. [Wikipediassa](http://en.wikipedia.org/wiki/List_of_text_editors) on kattava lista editoreista, mutta hyvään alkuun pääsee Windowsissa [notepad++](http://notepad-plus-plus.org/):lla ja OS X:ssä esim. [Aquamacs](http://aquamacs.org/)-emacs-pohjaisella editorilla. Linux-jakeluiden oletuseditorit ovat aivan kelpoja.

Markdown on tekstipohjainen merkintäkieli, joten sen kirjoittaminen ei vaadi kuin tekstieditorin. Markdown-muotoisen lähdekoodin kääntämiseen haluttuun formaattiin tarvitaan jo aiemmin mainittu pandoc, jota kehittää aktiivisesti Berkeleyn yliopiston filosofian professorin [John MacFarlane](http://johnmacfarlane.net/). Mikäli haluat kääntää tekstin tieteellisissä julkaisuissa suosittuun [LaTeX](http://fi.wikipedia.org/wiki/Latex)-formaattiin, niin sinun tulee asentaa koneellesi myös LaTeX. Alla on ohjeet sekä pandocin että latexin asentamiseen:

- [Pandoc:in asentaminen linuxiin, Mac OS X:ään ja Windowsiin](http://johnmacfarlane.net/pandoc/installing.html)  - latauksen ja asennuksen kesto n. 30s.
- [Latex:in asentaminen linuxiin, Mac OS X:ään ja Windowsiin](http://www.latex-project.org/ftp.html) - latauksen ja asennuksen kesto n. 60 min.

Seuraava esimerkki perustuu uusimpaan pandocin versioon [pandoc 1.12.0.2 (2013-09-20)](http://johnmacfarlane.net/pandoc/releases.html#pandoc-1.12.0.2-2013-09-20).


## Esimerkki tieteellisen tekstin lähdekoodista

Seuraavassa esiteltävä minimaalinen esimerkki sisältää: 

1. julkaisun tekstin markdown-muodossa sekä
2. viitattujen julkaisujen bibliografiset tiedot [BibTeX](http://en.wikipedia.org/wiki/BibTeX)-muodossa.

### 1. teksti markdown-muodossa

Tekstin alussa on [YAML](http://en.wikipedia.org/wiki/YAML)-muotoinen metadata-osio, johon tulee dokumentin metatiedot. Muilta osin teksti noudattelee markup-syntaxia lisättynä kahdella matemaattisella kaavalla sekä erityyppisillä lähdeviittauksilla kahteen artikkeliin. Merkintäkieli on helppolukuista myös *lähdekoodi*-muodossaan. Tässä demossa lähdeviitetiedoston nimi on *teksti.md*.

  ```r
---
title:  'Esimerkkiteksti kirjoitettuna markdown-merkintäkielellä'
author: Markus Kainu
affiliation: Turun yliopisto
date: Lokakuu 2013
bibliography: bibtex.bib
lang: finnish
tags: [markdown, pandoc]
...

# Suhteellisuusteoriasta ja Higgsin bosonista

## Suhteellisuusteoriasta

Lorem ipsum[^1] @einstein1935can dolor sit amet, consectetur adipiscing elit. Etiam at augue et quam placerat tristique [s. 12-15, @einstein1935can]. 

$e = mc^2$

Vestibulum ante ipsum [-@einstein1935can] primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris imperdiet sem odio, at pharetra mauris congue dignissim.

![Massa aiheuttaa poikkeaman avaruuden geometriassa](http://upload.wikimedia.org/wikipedia/commons/2/22/Spacetime_curvature.png)

[^1]: Alaviitteen teksti on tässä.

## Higgsin bosonista

Donec tortor justo, venenatis sodales fermentum ut, eleifend sit amet lorem. Curabitur rutrum faucibus leo, nec porttitor est consequat sit amet. [@lee1977weak]

![Tiettyjen partikkeleiden välisten suhteiden standardi-mallin mukainen tiivistelmä](kuvat/higgs.png)

Lorem ipsum dolor @lee1977weak [s. 35] sit amet, consectetur adipiscing elit. Etiam at augue et quam placerat tristique. 

$M_Z=\frac{v\sqrt{g^2+{g'}^2}}2$

Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris imperdiet sem odio, at pharetra mauris congue dignissim. Donec tortor justo, venenatis sodales fermentum ut, eleifend sit amet lorem. Curabitur rutrum faucibus leo, nec porttitor est consequat sit amet.

# Taulukot

Table: Einsteinin lapset

Syntymäaika Etunimet        Sukunimi    Sukupuoli
---------   --------        --------    ----------
14.05.1904  Hans, Albert    Einstein    mies
28.06.1910  Eduard          Einstein    mies

*Lähde: [wikipedia](http://fi.wikipedia.org/wiki/Albert_Einstein#Einsteinin_avioliitot)*


# Lähdeviitteet

  ```


### 2. lähdeviitteet BiBTeX-muodossa

Kenties yksinkertaisin tapa käyttää lähdeviitteitä on LaTeX-ladontajärjestelmästä tuttu [BibTeX](http://en.wikipedia.org/wiki/BibTeX)-muoto. Viitteet on mahdollista viedä kaikista viitteidenhallintaohjelmista ko. muotoiseen tekstitiedostoon. Google Scholar -palvelun hakutuloksissa on mm. [suora linkki osuman bibliografisten tietojen lataamiseen BibTeX-muodossa](http://www.youtube.com/watch?v=SsJSR2b4_qc). Tässä demossa lähdeviitetiedoston nimi on *bibtex.bib* ja se näyttää seuraavalta:

  ```r
@article{einstein1935can,
  title={Can quantum-mechanical description of physical reality be considered complete?},
  author={Einstein, Albert and Podolsky, Boris and Rosen, Nathan},
  journal={Physical review},
  volume={47},
  number={10},
  pages={777},
  year={1935},
  publisher={APS}
},

@article{lee1977weak,
  title={Weak interactions at very high energies: The role of the Higgs-boson mass},
  author={Lee, Benjamin W and Quigg, Chris and Thacker, Harry B},
  journal={Physical Review D},
  volume={16},
  number={5},
  pages={1519},
  year={1977},
  publisher={APS}
}

  ```

## Dokumentin kääntäminen pandoc-ohjelmalla

Pandoc-ohjelmaan ei ole olemassa graafista käyttöliittymää, vaan komennot tulee ajaa ns. *komentorivissä*. Windowsissa komentorivi voi olla hankalasti löydettävissä, mutta oheinen Jyväskylän yliopiston ohje auttaa asiassa: [Komentorivit Windowsissa: Command Prompt](http://users.jyu.fi/~nieminen/ohj1/materiaalia/tyokaluohjeet/komentorivi_selviytyminen.html#komentorivit-windowsissa-command-prompt). OS X:ssä komentorivin saa auki klikkailemalla: `Applications>Utilities>Terminal`. Linuxissa pikanäppäin `Ctrl + Alt + t`avaa päätteen.

Kun olet avannut komentorivin, sinun tulee vaihtaa hakemistoksi se hakemistoksi, jossa lähdekoodisi sijaitsee. Mikäli se on kansio `essee` työpöydällä, niin oikea komento voisi olla `cd desktop/essee`. Komentorivin komennot eroavat eri käyttöjärjestelmissä hieman, joten katso apua täältä: [Selviytymisopas: Komentorivin käyttö](http://users.jyu.fi/~nieminen/ohj1/materiaalia/tyokaluohjeet/komentorivi_selviytyminen.html) tai käytä googlea.

Kun olet saanut navigoitua itsesi oikeaan hakemistoon komentorivillä tulee sinun enää syöttää komento, joka kääntää lähdekoodin haluamaasi formaattiin. Erityisen yksinkertaisissa käännöksissä riittää yleensä `pandoc lahdekoodi.md -o haluttu_formaatti.xxx`. [Pandocin ohjeista](http://johnmacfarlane.net/pandoc/README.html) löytyy miltei rajaton määrä ohjeita kääntämisen hienosäätämiseen. Alla on komennot yleisimpiin käännöksiin siten, että myös matemaattiset kaavat sekä lähdeviitteet generoituvat käännettäessä.

  ```r

# latex-pdf -muotoon
pandoc teksti.md -o teksti.pdf --toc --number-section --latexmathml --filter pandoc-citeproc
# .html-muotoon
pandoc -s teksti.md -o teksti.html --toc --number-section --latexmathml --filter pandoc-citeproc
# .odt-muotoon
pandoc teksti.md -o teksti.odt --toc --number-section --latexmathml --filter pandoc-citeproc
# .docx-muotoon
pandoc teksti.md -o teksti.docx --toc --number-section --latexmathml --filter pandoc-citeproc
# .epub-muotoon
pandoc teksti.md -o teksti.epub --toc --number-section --latexmathml --filter pandoc-citeproc


  ```

## Lataukset

### Lähdekoodi, viitetiedot, kuvat ja komennot zipattuna

Zipatussa paketissa on lähdeteksti (teksti.md), viitteet (bibtex.bib), pandoc-komennot (komennot.md) sekä kansio `kuvat`, jossa kuva higgs.png. Toinen kuva tulee suoraan wikipediasta.

- [demo.zip](http://markuskainu.fi/material/blog/pandocmarkdown2013/demo.zip)

### Esimerkkiteksti eri formaateissa

- [teksti.pdf](http://markuskainu.fi/material/blog/pandocmarkdown2013/teksti.pdf)
- [teksti.html](http://markuskainu.fi/material/blog/pandocmarkdown2013/teksti.html)
- [teksti.odt](http://markuskainu.fi/material/blog/pandocmarkdown2013/teksti.odt)
- [teksti.docx](http://markuskainu.fi/material/blog/pandocmarkdown2013/teksti.docx)
- [teksti.epub](http://markuskainu.fi/material/blog/pandocmarkdown2013/teksti.epub)

html-käännös ilman tyylitiedostoa näyttää nykypäivän silmään luotaantyöntävältä ja sitä voi ehostaa esim. tämän css-tiedoston avulla: [markuskainu.fi/material/css/article.css](http://markuskainu.fi/material/css/article.css). Voit lisätä sen lähdekoodiin vaikkapa metatietojen alle oheisella koodilla

`<link href="http://markuskainu.fi/material/css/article.css"`
`rel="stylesheet" type="text/css" title="compact"></link>`

Muotoiltu html-muotoinen teksti näyttäisi sitten tältä: [teksti_css.html](http://markuskainu.fi/material/blog/pandocmarkdown2013/teksti_css.html)


## Lopuksi

Kirjoituksessa kuvattu työvirta ei tietenkään ole virheetön saati ns. *valmis*, mutta toimii hyvin jo tällaisenaan. Aivan erityisen hyödylliseksi kuvatun kaltainen työvirta tulee, mikäli tieteellinen tutkimus sisältää laskennallista analyysiä, jonka tuloksia (taulukoita, kuvioita) tekstissä esitellään. Mm. R-kielessä on olemassa erinomainen ekosysteemi laskennallisen analyysin ja sitä kuvaavan tekstin kirjoittamiseen rinnakkain yhteen tekstiin. Tähän ns. *toistettavan analyysin* lähdetymistapaan voi tutustua englanniksi juuri julkaistussa kirjassa [Xie, Yihui. 2014. Dynamic Documents with R and Knitr](http://www.crcpress.com/product/isbn/9781482203530) ([kirjan lähde githubissa](https://github.com/yihui/knitr-book)) tai suomeksi vaikka osoitteessa: [markuskainu.fi/workshop/toistettava/](http://markuskainu.fi/workshop/toistettava/). Asiaa käsiteltäneen myös tässä blogissa syksyn aikana. 



**Kysymyksiä ja kommentteja rohkeasti tuohon alapuolelle!**

[jekyll-gh]: https://github.com/mojombo/jekyll
[jekyll]:    http://jekyllrb.com
