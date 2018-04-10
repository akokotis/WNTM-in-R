#Word Network Topic Model
#Source: http://www.shizukalab.com/toolkits/sna/weighted-edgelists

# Packages
require("data.table")
require("dplyr")
require("tidyr")
require("stringr")
require("tidytext")
require("stringi")


# Load data
data=read.csv(file.choose(), stringsAsFactors=F)
str(data)
columns=c("external_id","name","description","category_names")
filtered=data[,columns]


# Cleaning
to_remove=read.csv("C:/Users/AnneKokotis/Documents/General Code/Special Symbols.csv", colClasses=c("character"), stringsAsFactors=F)

for(i in 1:nrow(to_remove)){
  value=to_remove$Special_Symbol[i]
  replace=to_remove$Replace[i]
  filtered$description=apply(filtered[,c('description'), drop = FALSE],1,function(x) gsub(value,replace,x))
}

## &frasl; represents slash /     Used in measurements
filtered$description=apply(filtered[,c('description'), drop = FALSE],1,function(x) gsub("&frasl;","/",x))

filtered$description=apply(filtered[,c('description'), drop = FALSE],1,function(x) gsub("\\Q.\\E"," ",x))

filtered$description=apply(filtered[,c('description'), drop = FALSE],1,function(x) gsub("\\Q-\\E"," ",x))


filtered[,sapply(filtered,is.character)] <- sapply(
  filtered[,sapply(filtered,is.character)],
  iconv,"WINDOWS-1252","UTF-8")


# Stopword
# R Sourced
require("tm")
stopwords_vector=stopwords(kind = "en")
stopwords=data_frame(word=stopwords(kind = "en"))

#Tokenization
onetoken_id= filtered %>%
  unnest_tokens(word, name) %>%
  anti_join(stopwords, by="word") %>%
  count(external_id,word, sort = FALSE) %>%
  ungroup()

onetoken_word= filtered %>%
  unnest_tokens(word, name) %>%
  anti_join(stopwords, by="word") %>%
  count(word, sort = TRUE) %>%
  ungroup()


#Word Pairs
require("widyr")
test=onetoken_id
word_pairs= test %>%
  pairwise_count(word, external_id, sort=F) %>%
  filter(n >= 2)



#Network Graph & Adjacency Matrix
require("igraph")
el=as.data.frame(word_pairs)
colnames(el)=c("V1","V2","weight")
g2=graph.data.frame(el)

adj=get.adjacency(g2,attr='weight',sparse=FALSE) 
head(adj)


#Classification
require("topicmodels")
require("servr")
require("LDAvis")
require("fpc")

