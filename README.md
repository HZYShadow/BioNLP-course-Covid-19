# BioNLP-course-Covid-19
《Covid-19 科学文献知识发现》中所用到的数据、代码

## 1.获取文献PMID
        esearch -db pubmed -query "covid-19" | efetch -format uid > pubmed_pmid.txt
使用该方法获得的PMID后会有特殊的换行符，可使用dos2unix命令对其进行转换

## 2.获取文献摘要及实体信息
        chmod +x ./bionlp/NCBI.sh 
        nohup sh ~/bionlp/NCBI.sh &
简化老师上课讲授shell脚本，修改shell脚本权限，在后台运行脚本获得文献信息result.txt

因为shell脚本挖文献的速度较慢，我们尝试了其他三种方式，相关代码在try文件夹中

## 3.提取出实体部分
        grep -vE "[0-9]{8}\|[ta]\|" result.txt > entity.txt
过滤文章标题及摘要部分，仅提取出实体部分

        grep -E "\bGene\b" entity.txt  > gene.txt
        grep -E "\bDisease\b" entity.txt  > disease.txt
        grep -E "\bChemical\b" entity.txt  > chemical.txt
        grep -E "Mutation\b" entity.txt  > mutation.txt
        grep -E "\bCellLine\b" entity.txt  > cell_line.txt
        grep -E "\bSpecies\b" entity.txt  > species.txt
分别从实体中提取出基因、疾病、化合物、突变等六类实体信息
data文件夹中为提取出的实体信息

## 4.分别统计出实体出现次数并绘制柱状图
该部分详细代码见bionlp.R。该部分分别对基因、疾病、化合物出现次数进行统计，绘制出对应柱状图，并找出出现次数靠前的实体信息。同时，我们对基因在染色体上的分布情况进行了统计，并绘制出分布图

data中gene_result.txt为从NCBI上获取的基因信息

## 5.找出与手动筛选的和Covid-19显著相关的13个基因出现在同意篇文献中的实体
该部分详细代码见bionlp_find.R。该部分通过使用for循环，找出与13个显著基因出现在一篇文献中的疾病和突变实体，并统计出实体出现频次
