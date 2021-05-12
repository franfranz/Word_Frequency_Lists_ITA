  ###
#
#     C O U N T   W O R D   O C C U R R E N C E S  in ItWaC lists
#
#     Countlemma ADJ     
#
#     https://github.com/franfranz/Word_Frequency_Lists_ITA
#
### 

#This was adapted to ADJ tagging from countlemma v2.1.0

#
#   0 - Set Directories 
#

# clean workspace
rm(list = ls())

# codewd (# where this code is stored)
codewd=getwd()

# input directory
wd_in="path"

# output directory 
# for processed files
wd_out="path"

# for final list of nouns
setwd(wd_out)
dir.create("Final_List")
wd_list=paste(wd_out, "\\Final_List", sep="")


#
#   1 - Process files 
#

# import files
setwd(wd_in)

# specify file extension
file.names=dir()[grep(".txt$", dir())]
#file.names=dir()[grep(".csv$", dir())]

# measure time of (unparallelized) process in local
s0_start_time <- Sys.time() 
timezero=NULL

for(myfile in file.names){
  #get time
  s1_start_time <- Sys.time() 
  #get letter from file name
  thename=tools::file_path_sans_ext(myfile)
  
  # choose how to 
  #nouns= read.table(myfile, header=F, sep="\t", encoding = "UTF-8", na.strings = "")
  nouns=read.delim(myfile, header=F, sep="\t", encoding = "UTF-8", na.strings = "")
  # set headers
  c_nam= c("form", "lemma", "POS", "n_txt")
  colnames(nouns)<- c_nam
  
  #discard text_id col
  nouns$n_txt=NULL
  nouns2=nouns[order(nouns$form), ]
  
  #nouns=NULL
  
  #check file status
  head(nouns2)
  summary(nouns2)
  str(nouns2)
  
  nouns2$POS=as.character(nouns2$POS)
  nouns2= nouns2[startsWith(nouns2$POS, "ADJ"), ]
  
  # count tokens in cols
  totlength=length((nouns2$form))
  
  # cut in 5 rough parts (+ residual)
  cut1= floor(totlength/5)
  
  # take each slice all the occurrences of a same word should belong to the same part
  # 
  
  #slice 1
  word1= nouns2[cut1, ]
  word1= as.character(word1$form)
  wordlines1=(which(nouns2$form==word1))
  cutpoint1= max(wordlines1) 
  file1= nouns2[c(1:cutpoint1), ]
  
  #cut slice 1 from whole df
  nouns2= nouns2[!(nouns2$form %in% file1$form), ]
  #nouns4=nouns2
  
  # slice 2
  totlength2=length((nouns2$form))
  cut2= floor(totlength2/4)
  file2= nouns2[c(1:cut2), ]
  lastline2=nrow(file2)
  word2= file2[(lastline2), ]
  word2= as.character(word2$form)
  
  wordlines2=(which(nouns2$form==word2))
  cutpoint2= max(wordlines2) 
  
  file2= nouns2[c(1:cutpoint2), ]
  
  #cut slice 2 from whole df
  nouns2= nouns2[!(nouns2$form %in% file2$form), ]
  
  
  # slice 3
  totlength3=length((nouns2$form))
  cut3= floor(totlength3/3)
  file3= nouns2[c(1:cut3), ]
  lastline3=nrow(file3)
  word3= file3[(lastline3), ]
  word3= as.character(word3$form)
  
  wordlines3=(which(nouns2$form==word3))
  cutpoint3= max(wordlines3) 
  
  file3= nouns2[c(1:cutpoint3), ]
  
  #cut slice 3 from whole df
  nouns2= nouns2[!(nouns2$form %in% file3$form), ]
  
  
  # slice 4
  totlength4=length((nouns2$form))
  cut4= floor(totlength4/2)
  file4= nouns2[c(1:cut4), ]
  lastline4=nrow(file4)
  word4= file4[(lastline4), ]
  
  word4= as.character(word4$form)
  
  wordlines4=(which(nouns2$form==word4))
  cutpoint4= max(wordlines4) 
  
  file4= nouns2[c(1:cutpoint4), ]
  
  #cut slice 1 from whole df
  nouns2= nouns2[!(nouns2$form %in% file4$form), ]
  
  
  # slice 5 + residual
  file5=nouns2
  nouns2=NULL
  
  
  #length(unique(nouns$form))
  #str(unique(nouns))
  
  # create a list with the objects 
  mylist=NULL
  mylist[[1]]=file1
  mylist[[2]]=file2
  mylist[[3]]=file3
  mylist[[4]]=file4
  mylist[[5]]=file5
  
  filenumbers=NULL
  for (i in 5:1){
    filenumber= paste("file", i, sep="")
    filenumbers=c(filenumber, filenumbers)
  }
  
  names(mylist)=filenumbers
  
  datnum=0 
  for (themfiles in mylist){
    datnum=  datnum+1
    thenumber=paste(thename, "_", datnum, sep="")
    
    nouns=themfiles
    
    
    # remove nouns with verb tag in the end
    thePOS= unique(nouns2$POS)
    for(eachpos in thePOS) {
      patt1= eachpos
      patt2= paste("_", eachpos, sep = "")  
      nouns$form <- gsub(pattern = patt1, x = nouns$form, replacement = '',ignore.case = F)
      nouns$form <- gsub(pattern = patt2, x = nouns$form, replacement = '',ignore.case = F)
    }
    
    # remove strings containing punctuation and numbers
    length(nouns$form)
    nouns=nouns[!grepl("[[:punct:]]", nouns$form,  ignore.case = T), ]
    nouns=nouns[!grepl("[[:digit:]]", nouns$form,  ignore.case = T), ]
    
    # lowercase everything
    nouns$form=tolower(nouns$form)
    
    # factor form column
    nouns$form=as.factor(nouns$form)
    
    # calculate token frequency
    token=as.data.frame(table(nouns$form))
    c_namtoken=c("Form", "Freq")
    colnames(token)<-c_namtoken
    summary(token)
    token$Form=as.factor(token$Form)
    str(token)
    
    # extract types
    type=unique(nouns)
    type$POS=as.character(type$POS)
    type$POS=as.factor(type$POS)
    summary(type)
    str(type)
    
    # merge type and tokens in a single df
    toktyp= merge(token, type, by.x = "Form", by.y = "form")
    #summary(toktyp)
    
    # print each df in the output directory
    setwd(wd_out)
    write.csv(toktyp, file = paste(thenumber, "_adjlist.csv", sep=""))
  }
  # back to the input directory
  setwd(wd_in)
  
  # measure and record time per loop
  s1_end_time <- Sys.time()
  s1_time <- s1_end_time - s1_start_time
  s1_time
  
  qtime= as.data.frame(s1_time)
  row.names(qtime) <- thename
  timezero=rbind(timezero, qtime)
  
}


# measure total time 
s0_time <- s1_end_time - s0_start_time
gtime=as.data.frame(s0_time)
row.names(gtime) <- "total_time"
colnames(gtime)<-"time"
colnames(timezero)<-"time"
loop_timestamp=rbind(timezero, gtime)
loop_timestamp$time=round(loop_timestamp$time, 3)



#
#   2 - Compose List merging separate files
#

# get files from previous output directory
setwd(wd_out)
dat0=NULL

# rbind files into a single list
file.names=dir()[grep(".csv$", dir())]
for (myfile in file.names){
  temp=read.csv(myfile, dec=".", sep=",", header=T)
  temp$X=NULL
  temp$n_txt=NULL
  dat0=rbind(dat0, temp)
}

summary(dat0)
dat0$X=NULL
# dat0$mode= gsub("VER:", "", dat0$POS)
# dat0$mode= gsub("VER2:", "", dat0$mode)
# dat0$POS2= substr(dat0$POS, 1, 4)
# dat0$POS2= gsub(":", "", dat0$POS2)
# 
# dat0$mode=as.factor(dat0$mode)
# dat0$POS2=as.factor(dat0$POS2)
# dat0$POS= rep("VER")
# dat0$POS= as.factor(dat0$POS)

# delete all occurrencies of words whose length >20
dat0$Form=as.character(dat0$Form)
dat0 = dat0[ which(nchar(dat0$Form)<25), ]
dat0$Form=as.factor(dat0$Form)

dat0 = dat0[ dat0$POS=="ADJ", ] 


# check! lemma frequency can be high in frequent verbs whose cells are filled throughout the paradigm 
lemmacheck=(as.data.frame(table(dat0$lemma)))

# a few examples
any(lemmacheck$Freq>50)
lemmaword=lemmacheck[lemmacheck$Freq>=50, ]

# a list of the most represented lemma types
lemmatypes=lemmacheck[lemmacheck$Freq!=0, ]
collemma=c("Lemma", "Freq")
colnames(lemmatypes)= collemma
lemmatypes= lemmatypes[order(-lemmatypes$Freq, lemmatypes$Lemma), ]

head(lemmatypes)
# check occurrences "zero": are they errors
zerolemma=lemmacheck[lemmacheck$Freq==0, ]
length(zerolemma$Freq)
range(lemmacheck$Freq)
head(dat0)
tail(dat0)


# cut tail of forms occurring up to 3 times - these are mostly typos. Many frequent typos will survive tho
dat1= dat0[dat0$Freq>2, ]

#order by frequency
dat_ord0= dat0[order(-dat0$Freq, dat0$lemma),]
dat_ord1= dat1[order(-dat1$Freq, dat1$lemma),]

tail(dat_ord0)
tail(dat_ord1)

summary(dat_ord0)
summary(dat_ord1)


# add column with frequency on Zipf scale

# calculate zipf frequency (applied oin fpmw)
zipffreq_pmw <- function (x) { 
  zipffreq_pmw <- (log10(x))+3
  zipffreq_pmw <- round(zipffreq_pmw, 3)
  return(zipffreq_pmw)
}

# corpus size (itwac)
corpussize<-1909826282

# to dat_ord0
dat_ord0$fpmw=((dat_ord0$Freq*10^6)/corpussize)
dat_ord0$fpmw=round(dat_ord0$fpmw,3)
dat_ord0$Zipf=mapply(zipffreq_pmw, dat_ord0$fpmw)

# to dat_ord1
dat_ord1$fpmw=((dat_ord1$Freq*10^6)/corpussize)
dat_ord1$fpmw=round(dat_ord1$fpmw,3)
dat_ord1$Zipf=mapply(zipffreq_pmw, dat_ord1$fpmw)

#
# 3 - Order, fix dupes, add measures and output
#


#if everything is ok, then output the final list in its dedicated directory:
setwd(wd_list)
write.csv(dat_ord0, file="itwac_adj_lemmas_raw_2_1_0.csv", row.names = F)
write.csv(dat_ord1, file="itwac_adj_lemmas_notail_2_1_0.csv", row.names = F)
write.csv(lemmatypes, file="itwac_adj_list_of_lemmas_2_1_0.csv", row.names = F)

# write timestamp if you like
write.csv(loop_timestamp, file="timestamp.csv", row.names = T)


# check files

datcheck_0=read.csv("itwac_adj_lemmas_raw_2_1_0.csv", dec=".", sep=",", header=T)
head(datcheck_0)
tail(datcheck_0)
summary(datcheck_0)
str(datcheck_0)
#plot(density(log(datcheck_0$Freq)))
#hist(datcheck_0$Freq, breaks=50)

datcheck_1=read.csv("itwac_adj_lemmas_notail_2_1_0.csv", dec=".", sep=",", header=T)
head(datcheck_1)
tail(datcheck_1)
summary(datcheck_1)
str(datcheck_1)
#plot(density(log(datcheck_1$Freq)))
#hist(datcheck_1$Freq, breaks=50)

datch_0_unique=unique(datcheck_0)
datch0_uni=as.data.frame(table(datch_0_unique$lemma))
summary(datch_0_unique)
summary(datcheck_0)

datch_1_unique=unique(datcheck_1)
datch1_uni=as.data.frame(table(datch_1_unique$lemma))
summary(datch_1_unique)
summary(datcheck_1)

