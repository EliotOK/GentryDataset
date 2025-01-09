# GentryDataset
An organized version for The Alwyn H. Gentry Forest Transect Data Set
一个整理好的gentry森林群落调查数据集

## 起因 Motivation
很简单，我在前往http://mobot.org/mobot/research/gentry/transect.shtml尝试复现Lu & Hedin(2019)在NEE上的文章(https://www.nature.com/articles/s41559-018-0759-0)时发现Gentry的数据集是非常原始的pdf扫描件+226个xls文档。Gentry当然是很伟大的植物学家和冒险家，但其记录方式已经过于落后以至于不再适用于当下的数据处理工具。于是我简单整理了一下，在解决了包括大小写不统一、对「个体数」这一指标的记录五花八门、OCR导致的il1不分等问题后，终于整理出了这么一份数据集。后面附加了密苏里植物园的网站没有给出的关于此数据集的详细说明。

## 内容 Content
- 一个用于复现Lu & Hedin(2019)中Fig.1结果的csv：gentry.csv
*共四列，第一列为站点缩写名Abbrev，后四列为计算的相对比基面积，计算基于数据集中的DBH*
*如果想计算重要值/个体数比值等指标请在R脚本文件*
- 一个用于处理从密苏里植物园官网下载的gentry原始数据的R脚本文件：gentry.R
- 一个压缩包，包含了gentry原始数据：gentry.zip
- 一个对扫描的站点坐标进行了OCR的xlsx文件，记录了各站点所属国家、完整名称、缩写、经纬度、降水、海拔等数据：gentry_loc.xlsx
