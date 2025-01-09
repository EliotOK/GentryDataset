setwd('D:/ShareCache/gzy/sci/arid/sPlot/gentry')
library(readxl)
library(geosphere)
library(stringr)


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

fungalType <- read.csv('fungus.type.csv')
locs <- read_excel("gentry_loc.xlsx")
locs$lat <- sapply(locs$Latitude, convert_to_decimal)
locs$lon<- sapply(locs$Longitude, convert_to_decimal)

ANKARIF <- read_excel("africa/ANKARIF.xls")
ANKARIF <- ANKARIF[, !grepl("vouch", names(ANKARIF))]
ANKARIF$BA <- apply(ANKARIF, 1, function(row) {
  # 提取N(IND.)
  n_ind <- as.numeric(row["N(IND.)"])
  
  # 提取所有直径列
  diameters <- as.numeric(row[7:length(row)]) # 从第7列开始
  
  # 移除NA值
  diameters <- diameters[!is.na(diameters)]
  
  # 计算基面积
  if (length(diameters) > 0) {
    ba <- sum((diameters / 2)^2) * pi / 4 * n_ind
  } else {
    ba <- 0
  }
  
  return(ba)
})


zones <- list.files()[c(1,3,9:12)]
gentry <- data.frame(plots = toupper(locs$Abbrev), ba.am = 0, ba.em = 0, ba.nm = 0)
rownames(gentry) <- toupper(locs$Abbrev)
for(i in zones){
  plots <- list.files(paste(i, '/', sep = ''))
  for(j in plots){
    print(i)
    print(j)
    d <- read_excel(paste(paste(i, '/', sep = ''), j, sep = ''))
    #d <- read_excel(paste(paste('samerica', '/', sep = ''), 'QUIAPACA.xls', sep = ''))
    match_col <- grep("N.*IND", names(d), value = TRUE, ignore.case = T)
    d$BA <- apply(d, 1, function(row) {
      diameters <- as.numeric(row[which(names(d)==match_col)+1:length(row)])
      diameters <- diameters[!is.na(diameters)]
      if (length(diameters) > 0) {
        ba <- sum((diameters / 2)^2) * pi
      } else {
        ba <- 0
      }
      return(ba)
    })
    colnames(d) <- gsub("(?i)genus", "Genus", colnames(d), perl = TRUE)
    d$Genus <- str_to_title(d$Genus)
    d.matched <- merge.data.frame(d, fungalType, by = 'Genus', all=F)
    ba.all <- sum(d.matched$BA)
    ba.am <- sum(subset(d.matched, Mycorrhizal.type == 'AM')$BA)/ba.all
    ba.em <- sum(subset(d.matched, Mycorrhizal.type %in% c('EcM', 'ErM'))$BA)/ba.all
    ba.nm <- sum(subset(d.matched, Mycorrhizal.type == 'NM')$BA)/ba.all
    gentry[substr(j, 1, nchar(j)-4), 'ba.am'] <- ba.am
    gentry[substr(j, 1, nchar(j)-4), 'ba.em'] <- ba.em
    gentry[substr(j, 1, nchar(j)-4), 'ba.nm'] <- ba.nm
    # calculate relative dominance
    ## match the mycorrhizal type
  }
}
gentry$plots <- row.names(gentry)
write.csv(gentry, 'gentry.csv')
# compiled
gentry.neo <- read.csv('gentry.csv')
locs$Abbrev <- str_to_upper(locs$Abbrev)
gentry.neo <- merge(gentry.neo, locs[, c(4, 9, 10)], by = 'Abbrev', all = F)
write.csv(gentry.neo, 'gentry.csv')
