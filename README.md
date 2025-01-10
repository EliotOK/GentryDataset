# GentryDataset
一个整理好的gentry森林群落调查数据集 
<br>An organized version for The Alwyn H. Gentry Forest Transect Data Set

## 起因 Motivation
很简单，我在前往 http://mobot.org/mobot/research/gentry/transect.shtml 尝试复现 Lu & Hedin (2019) 在 NEE 上的文章 (https://www.nature.com/articles/s41559-018-0759-0) 时发现 Gentry 的数据集是非常原始的 pdf 扫描件 + 226 个 xls 文档。Gentry 当然是很伟大的植物学家和冒险家，但其记录方式已经过于落后以至于不再适用于当下的数据处理工具。于是我简单整理了一下，在解决了包括大小写不统一、对「个体数」这一指标的记录五花八门、OCR 导致的 il1 不分等问题后，终于整理出了这么一份数据集。后面附加了密苏里植物园的网站没有给出的关于此数据集的详细说明。  

Quite simple. While trying to reproduce the results of Lu & Hedin (2019)’s NEE article (https://www.nature.com/articles/s41559-018-0759-0) from http://mobot.org/mobot/research/gentry/transect.shtml , I found that Gentry’s dataset was a collection of very raw scanned PDFs and 226 Excel files. Gentry was undoubtedly a great botanist and adventurer, but his recording methods have become too outdated for modern data processing tools. Therefore, I organized it. After addressing issues such as inconsistent capitalization, diverse ways of recording "individual numbers," and OCR errors like the confusion of i, l, and 1, I finally produced this dataset. I also included a detailed explanation of this dataset that was missing from the Missouri Botanical Garden website.  

## 内容 Content
一个用于复现 Lu & Hedin (2019) 中 Fig.1 结果的 csv：gentry.csv 

*共四列，第一列为站点缩写名 Abbrev，后四列为计算的相对比基面积，计算基于数据集中的 DBH* 
如果想计算重要值/个体数比值等指标请在 R 脚本文件中进行修改  

A CSV file (gentry.csv) for reproducing Fig.1 in Lu & Hedin (2019):
*Contains four columns: the first column is the site abbreviation (Abbrev), and the remaining columns are calculated relative basal areas based on DBH in the dataset.
To calculate importance values, individual-to-basal area ratios, or similar indices, please refer to the R script.*  

一个用于处理从密苏里植物园官网下载的 Gentry 原始数据的 R 脚本文件：gentry.R  

An R script (gentry.R) for processing the raw Gentry dataset downloaded from the Missouri Botanical Garden website.  

一个压缩包，包含了 Gentry 原始数据：gentry.zip  

A compressed file (gentry.zip) containing the raw Gentry dataset.  

一个对扫描的站点坐标进行了 OCR 的 xlsx 文件，记录了各站点所属国家、完整名称、缩写、经纬度、降水、海拔等数据：gentry_loc.xlsx  

An OCR-processed XLSX file (gentry_loc.xlsx) documenting site-level metadata, including country, full site name, abbreviation, latitude/longitude, precipitation, and so on.  

一个菌根类型数据集，包含了 genus(属) 和菌根类型两列，来自 FungalRoot 数据库：fungus.type.csv  

A dataset of mycorrhizal types (fungus.type.csv) with two columns: genus and mycorrhizal type, sourced from the FungalRoot database.  
