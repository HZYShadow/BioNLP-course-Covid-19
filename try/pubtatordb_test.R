## author: 黄紫嫣
##利用pubtatordb中函数提取实体信息
#软件包“ pubtatordb”提供了一组函数，这些函数使普通R用户可以轻松地下载“ PubTator”注释，创建然后查询数据库的本地版本。
install.packages("pubtatordb")
library(pubtatordb)
setwd(choose.dir())  #进入文件所在目录
download_pt(getwd())
pubtator_path <- file.path(getwd(), "PubTator") 
pt_to_sql(“PubTator”)    #从pubtator数据创建sqlite数据库

##理论上该方法可以直接建库查询，但在对六类实体的识别和注释存在错误，故该方法也为能够真正实现
