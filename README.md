# venn_diagram_generator
An R Shiny app that will take two or three species lists and create a Venn diagram.

Designed to work specifically with 'abundance' files generated as part of the post-centrifuge ancient metagenomic pipeline (see [here](https://github.com/DrATedder/ancient_metagenomics "Link to 'Ancient Metagenomics' GitHub repository"), although it will work with simple species lists also), this simple shiny app will take either two or three files and create a venn diagram based on the number of unique and overlapping species. The user can choose the output figure format ('png' or 'pdf'), and name the output figure according to their own requirements.

## Appearance
![Shiny app](https://github.com/DrATedder/venn_diagram_generator/blob/8f21111f13a8402835b8bdfe8ec5cdb1f49f736e/Venn_diagram_shiny.png "Shiny App appearance image")

## Prerequisites

The following libraries are required to run the app:
- shiny
- VennDiagram
- dplyr
- grid
- png

These can be installed through R or Rstudio in the following way:

```R
install.packages('shiny')

install.packages('VennDiagram')

install.packages('dplyr')

install.packages('grid')

install.packages('png')
```

## Input files

The Shiny app will take input files that are as simple as lists of species (no header row required), but it was developed as part of a pipeline of applications to anaylse ancient metagenomic data, and so it will accept 'abundance' file generated as part that process (see [here](https://github.com/DrATedder/ancient_metagenomics "Link to 'Ancient Metagenomics' GitHub repository") for more details). Briefly, 'abundance' files have the following format:


|  OTU   |  UniqR   | Abundance   |
| --- | --- | --- |
|Azorhizobium caulinodans | 1725 | 0.03|
|Cellulomonas gilvus | 2019 | 0.03|
|Myxococcus xanthus | 5519 | 0.08|
|Myxococcus macrosporus | 4463 | 0.07|
|Stigmatella aurantiaca | 1622 | 0.02|
|Cystobacter fuscus | 2504 | 0.04|
|Archangium gephyra | 3011 | 0.04|
|Chondromyces crocatus | 1719 | 0.03|
|Sorangium cellulosum | 16403 | 0.24|
|Vitreoscilla filiformis | 1746 | 0.03|
|Lysobacter enzymogenes | 44962 | 0.66|
|Stella humosa | 2887 | 0.04| 

**Note**. Column headers are for illustrative purposes only. Abundance files are output without headers.

**File naming protocol:** Input files ('abundance' type or otherwise) should be named in the following manner:

`> shortname_anything.txt`

1.    shortname: used to label individuals within the venn diagram
2.    anything.txt: not used, but can be anything
3.    underscores ('_') must be used between file name elements as these are used for splitting file names

## Output example

![Example output](https://github.com/DrATedder/venn_diagram_generator/blob/8f21111f13a8402835b8bdfe8ec5cdb1f49f736e/Venn_diagram_output.png "Example app output")

## Web-based shiny implementation

If you prefer to use a web implementation of this app, you can find it [here](https://dratedder.shinyapps.io/venn_diagram_web/ "Link to web implementation of the app").
