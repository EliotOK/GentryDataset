setwd('anypath')
library(readxl)
library(geosphere)
library(stringr)
# if not installed, then :
# install.packages('readxl')
# install.packages('geosphere')
# install.packages('stringr')

# 转换经纬度为标准经纬度
convert_to_decimal <- function(dms) {
  # 提取数字部分和方向
  parts <- unlist(strsplit(dms, "[°'\"]")) # 按 ° ' " 分割
  degree <- as.numeric(parts[1])           # 度
  minute <- ifelse(length(parts) > 2, as.numeric(parts[2]), 0) # 分（默认0）
  second <- ifelse(length(parts) > 3, as.numeric(parts[3]), 0) # 秒（默认0）
  direction <- gsub(" ", "", parts[length(parts)]) # 方位（去空格）
  
  # 计算十进制格式
  decimal <- degree + minute / 60 + second / 3600
  
  # 根据方向调整正负
  if (direction == "S" || direction == "W") {
    decimal <- -decimal
  }
  return(decimal)
}

# 读取菌根类型信息
fungalType <- read.csv('fungus.type.csv')

# 读取坐标信息
locs <- read_excel("gentry_loc.xlsx")
locs$lat <- sapply(locs$Latitude, convert_to_decimal)
locs$lon<- sapply(locs$Longitude, convert_to_decimal)

# 获取数据集中的文件列表。zones应该包含6个大洲的名称
zones <- list.files()[c(1,3,9:12)]

# 创建储存数据的文件数据框
gentry <- data.frame(plots = toupper(locs$Abbrev), ba.am = 0, ba.em = 0, ba.nm = 0)
rownames(gentry) <- toupper(locs$Abbrev)

# 循环以填充数据，别问我为什么循环套循环，问就是没过脑子想到就写了反正数据量不大
for(i in zones){
  plots <- list.files(paste(i, '/', sep = ''))
  for(j in plots){
    print(i)
    print(j)
    d <- read_excel(paste(paste(i, '/', sep = ''), j, sep = ''))
    
    # the below line is used to test the bugs, just ignore it
    # d <- read_excel(paste(paste('samerica', '/', sep = ''), 'QUIAPACA.xls', sep = ''))

    # 模糊匹配个体数
    match_col <- grep("N.*IND", names(d), value = TRUE, ignore.case = T)

    # BA means Basal Area
    d$BA <- apply(d, 1, function(row) {
      diameters <- as.numeric(row[which(names(d)==match_col)+1:length(row)])
      diameters <- diameters[!is.na(diameters)]
      if (length(diameters) > 0) {
        # as we all know the area of a circle equals πr^2
        ba <- sum((diameters / 2)^2) * pi
      } else {
        ba <- 0
      }
      return(ba)
    })
    
    # 继续模糊匹配替换掉所有不规范的拼写
    colnames(d) <- gsub("(?i)genus", "Genus", colnames(d), perl = TRUE)
    d$Genus <- str_to_title(d$Genus)

    # 基于genus匹配菌根类型
    d.matched <- merge.data.frame(d, fungalType, by = 'Genus', all=F)

    # 计算总基面积和相对基面积/优势度
    # calculate relative dominance
    ba.all <- sum(d.matched$BA)
    ba.am <- sum(subset(d.matched, Mycorrhizal.type == 'AM')$BA)/ba.all
    ba.em <- sum(subset(d.matched, Mycorrhizal.type %in% c('EcM', 'ErM'))$BA)/ba.all
    ba.nm <- sum(subset(d.matched, Mycorrhizal.type == 'NM')$BA)/ba.all
    gentry[substr(j, 1, nchar(j)-4), 'ba.am'] <- ba.am
    gentry[substr(j, 1, nchar(j)-4), 'ba.em'] <- ba.em
    gentry[substr(j, 1, nchar(j)-4), 'ba.nm'] <- ba.nm
  }
}

# it should be OK now, but I suggest to check twice (if it's 225 plots)
gentry$plots <- row.names(gentry)
write.csv(gentry, 'gentry.csv')

# match the locations
gentry.neo <- read.csv('gentry.csv')
locs$Abbrev <- str_to_upper(locs$Abbrev)
gentry.neo <- merge(gentry.neo, locs[, c(4, 9, 10)], by = 'Abbrev', all = F)
write.csv(gentry.neo, 'gentry.csv')
