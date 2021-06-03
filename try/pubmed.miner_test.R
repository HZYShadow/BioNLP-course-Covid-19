## author: 黄紫嫣
##利用pubmed.mineR进行文本挖掘，获得实体信息
#abstract-covid19-set.txt为PubMed上直接下载的部分文献摘要，这里作为测试文件
library(pubmed.mineR)
pubmed_abstracts<-readabs("abstract-covid19-set.txt") #读入测试文件
pmid<-pubmed_abstracts@PMID  #获取PMID
pubtator_output<-pubtator_function(pmid)  #获取PMID对应的注释信息

##这里可以对通过esearch提取出的pubmed_pmid.txt中的PMID进行处理，使用pubtator_function()获得注释信息
##理论上该方法可行，但是无论怎么调试都出现了报错信息
