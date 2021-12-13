add_readnames_nanovar <- function(nanovar_vcf,sv_support_tsv,outfile){
  
  library(tidyverse)
  library("glue")
  
  
  
  rn <-read.table(sv_support_tsv,sep = "\t", header = T)
  
  #Extract the read names from the ins_bed
  grep_rnames <- function(x){
    k <- str_match_all(x, "[a-zA-Z0-9]{8}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{12}")
    y <- glue_collapse(k[[1]][,1], sep = ",")
    return(y)
  }
  
  j <- sapply(rn$Supporting_reads..readname.index1.readname.index2...., grep_rnames)
  
  bind_cols(rn,j) -> rn
  colnames(rn) <- c("ID","supp","RNAMES")
  
  
  #Split up vcf
  vcf <- as.data.frame(readLines(nanovar_vcf),stringsAsFactors = F)
  colnames(vcf) <- "V1"
  
  idx <- grepl("^#", vcf[,"V1"], ignore.case=TRUE)
  header <- vcf[idx,]
  data <- vcf[!idx,]
  
  rm(idx)
  rm(vcf)
  
  data <- as.data.frame(data)
  colnames(data) <- "V1"
  
  data1 <- data.frame(do.call('rbind', strsplit(as.character(data$V1),'\t',fixed=TRUE)))
  data2 <- data.frame(do.call('rbind', strsplit(as.character(data1$X8),';',fixed=TRUE)))
  
  data <- bind_cols(data1[,1:7],data2,data1[,9:10])
  colnames(data) <- c("CHR","START","ID","a","b","c","d","SVTYPE","END","SVLEN","SR","NN","e","f")
  
  merge(data,rn[,c(1,3)], by = "ID",all.x = T) -> data
  
  data$RNAMES2 = paste0("RNAMES=",data$RNAMES)
  
  #Remove text from info-field
  data %>% unite(info, SVTYPE,RNAMES2,END ,SVLEN,sep = ";") %>% select(CHR,START,ID,a,b,c,d,info,e,f) -> vcf
  
  
  paste(vcf$CHR, vcf$START, vcf$ID, vcf$a, vcf$b, vcf$c, vcf$d, vcf$info, vcf$e, vcf$f,sep = "\t") -> h
  
  as.data.frame(header) -> k
  as.data.frame(h) -> h

  colnames(k) <- "a"
  colnames(h) <- "a"
  
  dplyr::bind_rows(k,h) -> final
  
  write.table(final,outfile,quote = F,row.names = F, col.names = F)
  
}
