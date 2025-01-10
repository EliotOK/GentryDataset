# GentryDataset
一个整理好的gentry森林群落调查数据集 
<br>An organized version for The Alwyn H. Gentry Forest Transect Data Set

## 起因 Motivation
很简单，我在前往 http://mobot.org/mobot/research/gentry/transect.shtml 尝试复现 Lu & Hedin (2019) 在 NEE 上的文章 (https://www.nature.com/articles/s41559-018-0759-0) 时发现 Gentry 的数据集是非常原始的 pdf 扫描件 + 226 个 xls 文档。Gentry 当然是很伟大的植物学家和冒险家，但其记录方式已经过于落后以至于不再适用于当下的数据处理工具。于是我简单整理了一下，在解决了包括大小写不统一、对「个体数」这一指标的记录五花八门、OCR 导致的 il1 不分等问题后，终于整理出了这么一份数据集。后面附加了密苏里植物园的网站没有给出的关于此数据集的详细说明。  

Quite simple. While trying to reproduce the results of Lu & Hedin (2019)’s NEE article (https://www.nature.com/articles/s41559-018-0759-0) from http://mobot.org/mobot/research/gentry/transect.shtml , I found that Gentry’s dataset was a collection of very raw scanned PDFs and 226 Excel files. Gentry was undoubtedly a great botanist and adventurer, but his recording methods have become too outdated for modern data processing tools. Therefore, I organized it. After addressing issues such as inconsistent capitalization, diverse ways of recording "individual numbers," and OCR errors like the confusion of i, l, and 1, I finally produced this dataset. I also included a detailed explanation of this dataset that was missing from the Missouri Botanical Garden website.  

## 内容 Content
一个用于复现 Lu & Hedin (2019) 中 Fig.1 结果的 csv：gentry.csv 

共四列，第一列为站点缩写名 Abbrev，后四列为计算的相对比基面积，计算基于数据集中的 DBH
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

## 关于原始数据
1. gentry_coordinates.pdf
这是一个对站点经纬度及其他信息记录的扫描件，看得出来很有些年头了。我利用gpt进行了ocr工作并进行了一些校对，目前可以直接读取gentry_loc.xlsx获取其中的数据。它与其他数据的匹配主要基于Abbrev这一列。<br>
"Gentry_coordinates.pdf" is a scanned document that records the latitude and longitude of stations along with other information. It appears to be quite old. I have used GPT to perform OCR on it and carried out some proofreading. Now, the data can be directly accessed through "gentry_loc.xlsx". The matching with other data is mainly based on the "Abbrev" column.<br>

2. 分配于6个文件夹中的共225个xls表格
每个表格是对一个站点的记录。<br>
第1\~4行为科属种的记录，其中M1等记录表示未定种/定属；<br>
之后的voucher1\~vouchern是对标本的记录，通常可以忽略；<br>
LIANA（大小写在不同表格中有差异）表示该植物是否为藤本；<br>
N.IND/N(IND)/N(Ind)等可以模糊匹配至NIND的列表示该物种的个体数；<br>
其后的STEMDBH表示记录的胸径，其列数由NIND列决定。<br>
There are 225 xls spreadsheets distributed across 6 folders, each documenting a site. The first to fourth rows record the family, genus, and species, where "M1" and similar notations indicate undetermined species or genera.<br>
The records following "voucher1" to "vouchern" pertain to specimens and can generally be disregarded. The term "LIANA" (with variations in capitalization across different spreadsheets) signifies whether the plant is a liana.<br>
Entries such as "N.IND", "N(IND)", or "N(Ind)" can be loosely matched to the "NIND" list, which represents the number of individuals of the species.<br>
The subsequent "STEMDBH" column records the diameter at breast height, and the number of its columns is determined by the "NIND" column.<br>

