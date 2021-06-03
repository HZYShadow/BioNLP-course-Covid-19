## create by 孙阳
#sessionInfo()
#R version 4.0.5 (2021-03-31)
#Platform: x86_64-w64-mingw32/x64 (64-bit)
#Running under: Windows 10 x64 (build 19042)

#setwd() #将工作目录设置为存有文本的目录
#读入文本为一个list
filelist <- list.files(pattern=".*.txt")
filelist
m<-length(filelist)
entitylist <- lapply(filelist, function(x) read.csv(x,header = F,sep = "\t",col.names = c("pmid","start","end","name","type","ID")))
names(entitylist)<-c("cell_lines","chemical","disease","gene","mutation","species")
gene_table<-as.data.frame(table(entitylist[["gene"]]$ID)) 
View(gene_table)
gene_table[1,]
gene_table<-gene_table[-1,]  #去除没有识别成功的
gene_ord<-gene_table[order(gene_table$Freq,decreasing = T),] #对频率进行从大到小排序
head(gene_ord,10)  #查看最多的前十个
g1<-tapply(gene$ID,gene$pmid,table) ##另一种出现频率统计方法（按照pmid）
##如果不考虑基因实体在文章内部出现次数，只考虑该基因实体是否在某篇文章中出现，以此来统计频率
g<-gene[,-(2:5)] #只取pmid和ID列
g <- g[!duplicated(g),] #去重
g2<-as.data.frame(table(g$ID))
g2<-g2[-1,]
go<-g2[order(g2$Freq,decreasing = T),]
head(go,10)
p<-ggplot(subset(g2,Freq>30),aes(Var1,Freq))
p<-p+geom_bar(stat = "identity")
p<-p+theme(axis.text = element_text(angle = 45,hjust = 1))
p

##disease
diease<-as.data.frame(entitylist[["diease"]])
diease<-diease[!duplicated(diease$ID),] ##去重
ace1<-g[g$ID=="1636",] #g是经过去重的gene table，且只包含pmid和ID
ace1_d<-merge(ace1,diease,by="pmid")
ace1_d<-ace1_d[,-(3:4)]
##chemical
chemical_table<-as.data.frame(table(entitylist[["chemical"]]$ID))
chemical_table<-chemical_table[-(1:2),]
chemical<-entitylist[["chemical"]]
chemical_table<-merge(chemical_table,chemical,by.x="Var1",by.y = "ID")
chemical_table<-chemical_table[-(3:6)]
chemical_ord<-chemical_table[order(chemical_table$Freq,decreasing = T),]
#绘图
p<-ggplot(subset(chemical_table,Freq>500),aes(name,Freq))
p<-p+geom_bar(stat = "identity")
p<-p+theme(axis.text = element_text(angle = 45,hjust = 1)) 
##基因在染色体上分布情况柱状图
gene_result<-read.csv(file.choose(),header = T,sep = "\t") #导入gene_result文件
hg<-gene_result[gene_result$Org_name=="Homo sapiens",] #获取人类基因
chr<-as.data.frame(table(hg$chromosome)) #获取染色体出现频次
chr<-chr[-1,] #去除空的
#绘图
ggplot(data=chr,mapping=aes(x=Var1,y=Freq,fill=Var1,group=factor(1)))
  +   geom_bar(stat="identity")
  +   geom_text(aes(label = Freq, vjust = -0.8, hjust = 0.5, color = Var1))+xlab("Chromosome")+theme(legend.position = "none")
