front_matter<-
'---
title: \"經濟1A學生自介\"
author: \"ML\" 
date: \" September 6, 2017\" 
output: ioslides_presentation
---'

knitr.txt<-'
```{r setup, include=FALSE}\n
knitr::opts_chunk$set(echo = FALSE)\n
```
'

library(googlesheets)
library(dplyr)
#gs_auth(new_user = TRUE) # 若有googlesheets讀取問題，請執行此行。
gs_ls()
member.gs <- gs_title("導生106A")
member.gs %>% gs_read(ws = 'Form Responses 1') -> student.list 

body.txt<-c()
for(i in 1:dim(student.list)[1]){
  #i<-1
  name<-student.list$姓名[i]
  activities<-student.list$那些你想參加[i]
  club<-student.list$`你想參加什麼社團？`[i]
  hobby<-student.list$`你的興趣是什麼？`[i]
  fb<-student.list$`臉書追踪的粉專或加入的社團（列舉不超過3個）`[i]
  
  #slide.title<-paste0('## ', name)
  body.txt.i<-paste0('## ', name,'\n',
                     '- 想參加：   ', '\n',activities, '\n',
                   '- 社團興趣：  ', '\n',club,'\n',
                   '- 興趣：  ', '\n',hobby,'\n',
                   '- 臉書追踪:  ', '\n',fb,'\n')
  body.txt<-paste0(body.txt,'\n',body.txt.i)
}

full.body<-paste0(
  front_matter,'\n',
  knitr.txt,'\n',
  body.txt
)

fileConn<-file('slide_markdown_out.Rmd')
writeLines(c(front_matter,
             knitr.txt,
             body.txt), fileConn)
close(fileConn)

