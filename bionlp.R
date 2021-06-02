#sessionInfo()
#R version 4.0.5 (2021-03-31)
#Platform: x86_64-w64-mingw32/x64 (64-bit)
#Running under: Windows 10 x64 (build 19042)

#setwd() #������Ŀ¼����Ϊ�����ı���Ŀ¼
#�����ı�Ϊһ��list
filelist <- list.files(pattern=".*.txt")
filelist
m<-length(filelist)
entitylist <- lapply(filelist, function(x) read.csv(x,header = F,sep = "\t",col.names = c("pmid","start","end","name","type","ID")))
names(entitylist)<-c("cell_lines","chemical","disease","gene","mutation","species")
gene_table<-as.data.frame(table(entitylist[["gene"]]$ID)) 
View(gene_table)
gene_table[1,]
gene_table<-gene_table[-1,]  #ȥ��û��ʶ��ɹ���
gene_ord<-gene_table[order(gene_table$Freq,decreasing = T),] #��Ƶ�ʽ��дӴ�С����
head(gene_ord,10)  #�鿴����ǰʮ��
g1<-tapply(gene$ID,gene$pmid,table) ##��һ�ֳ���Ƶ��ͳ�Ʒ���������pmid��
##��������ǻ���ʵ���������ڲ����ִ�����ֻ���Ǹû���ʵ���Ƿ���ĳƪ�����г��֣��Դ���ͳ��Ƶ��
g<-gene[,-(2:5)] #ֻȡpmid��ID��
g <- g[!duplicated(g),] #ȥ��
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
diease<-diease[!duplicated(diease$ID),] ##ȥ��
ace1<-g[g$ID=="1636",] #g�Ǿ���ȥ�ص�gene table����ֻ����pmid��ID
ace1_d<-merge(ace1,diease,by="pmid")
ace1_d<-ace1_d[,-(3:4)]
##chemical
chemical_table<-as.data.frame(table(entitylist[["chemical"]]$ID))
chemical_table<-chemical_table[-(1:2),]
chemical<-entitylist[["chemical"]]
chemical_table<-merge(chemical_table,chemical,by.x="Var1",by.y = "ID")
chemical_table<-chemical_table[-(3:6)]
chemical_ord<-chemical_table[order(chemical_table$Freq,decreasing = T),]
#��ͼ
p<-ggplot(subset(chemical_table,Freq>500),aes(name,Freq))
p<-p+geom_bar(stat = "identity")
p<-p+theme(axis.text = element_text(angle = 45,hjust = 1)) 
##������Ⱦɫ���Ϸֲ������״ͼ
gene_result<-read.csv(file.choose(),header = T,sep = "\t") #����gene_result�ļ�
hg<-gene_result[gene_result$Org_name=="Homo sapiens",] #��ȡ�������
chr<-as.data.frame(table(hg$chromosome)) #��ȡȾɫ�����Ƶ��
chr<-chr[-1,] #ȥ���յ�
#��ͼ
ggplot(data=chr,mapping=aes(x=Var1,y=Freq,fill=Var1,group=factor(1)))
  +   geom_bar(stat="identity")
  +   geom_text(aes(label = Freq, vjust = -0.8, hjust = 0.5, color = Var1))+xlab("Chromosome")+theme(legend.position = "none")