## create by 黄紫嫣
diff_gene <- c(59272,1401,43740568,7113,7124,920,8673700,1636,925,5045,70008,5972,1803) #输入显著基因列表
gene<-read.table("gene.txt",sep = '\t')
##统计与显著基因出现在同一篇文献中的疾病
disease <- read.table("disease.txt",sep = '\t')
tmp <- c()
#找出文献中出现的显著基因
for( i in diff_gene){
  tmp <- append(tmp,which(gene$V6 == i))
}
tmp2 <- gene[tmp,]  #得到显著基因对应基因信息
pmid <- unique(tmp2$V1)  #得到去重后的pmid
tmp3 <- c()
#找出pmid对应的疾病
for (j in pmid) {
  tmp3 <- append(tmp3,which(disease$V1 == pmid))
}
final_disease <- disease[tmp3,]
Freq_disease <- as.data.frame(table(final_disease$V4))  #统计出与显著基因存在于同一篇文献中的疾病的频次

##统计与显著基因出现在同一篇文献中的突变
mutation <- read.table("mutation.txt",sep = '\t')
tmp4 <- c()
for( i in diff_gene){
  tmp4 <- append(tmp4,which(gene$V6 == i))
}
tmp5 <- gene[tmp4,]  #得到显著基因对应基因信息
pmid <- unique(tmp5$V1)  #得到去重后的pmid
tmp6 <- c()
#找出pmid对应的突变
for (j in pmid) {
  tmp6 <- append(tmp6,which(mutation$V1 == pmid))
}
final_mutation <- mutation[tmp6,]
Freq_mutation <- as.data.frame(table(final_mutation$V4))  #统计出与显著基因存在于同一篇文献中的突变的频次
