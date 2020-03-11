library(jsonlite)

library(dbplyr)
library(tidyjson)
library(dplyr)
library(tidyverse)
input_data<-read.csv("ga-customer-revenue-prediction/train.csv", header = TRUE)
head(input_data)
input_data$totals=as.character(input_data$totals)
input_data$device=as.character(input_data$device)
input_data$geoNetwork=as.character(input_data$geoNetwork)
input_data$trafficSource=as.character(input_data$trafficSource)
new_data <- input_data %>% 
   pull(totals) %>% 
   map(.,~fromJSON(.x)) %>% 
   map(.,as_tibble) %>% 
   bind_rows() %>% 
   bind_cols() %>% 
   bind_cols(input_data) 
   

new_data <- input_data %>% 
   pull(device) %>% 
   map(.,~fromJSON(.x)) %>% 
   map(.,as_tibble) %>% 
   bind_rows() %>% 
   bind_cols() %>% 
   bind_cols(input_data)  
   

new_data <- input_data %>% 
   pull(geoNetwork) %>% 
   map(.,~fromJSON(.x)) %>% 
   map(.,as_tibble) %>% 
   bind_rows() %>% 
   bind_cols() %>% 
   bind_cols(input_data) 

tr_trafficSource <- paste("[", paste(input_data$trafficSource, collapse = ","), "]") %>% fromJSON(flatten = T)
dim(tr_trafficSource)
tr_trafficSource <- data.frame(tr_trafficSource)
new_data <- new_data %>% bind_cols(tr_trafficSource)

write_csv(new_data,path="ga-customer-revenue-prediction/train_final.csv")


# df1 <- input_data %>% 
#    pull(trafficSource) %>% 
#    map(.,~fromJSON(.x)) %>% 
#    map(.,as_tibble) %>% 
#    bind_rows() %>% 
#    bind_cols()
# #   filter(is.na(isTrueDirect)) %>% 
# #   View
# #   unnest(cols=c() %>% 
# #   View()
# #   bind_cols(input_data) %>% 
# #   View()
# 
# fromJSON("{\"campaign\": \"(not set)\", \"source\": \"google\", \"medium\": \"organic\", \"keyword\": \"(not provided)\", \"adwordsClickInfo\": {\"criteriaParameters\": \"not available in demo dataset\"}}",simplifyDataFrame = TRUE)
# 
# 
# json_cols <- train[,c(3,5,8,9)]
# 
# j <- fromJSON(txt=train$totals,simplifyDataFrame = TRUE)
# 
# #JSON columns are "device", "geoNetwork", "totals", "trafficSource"
# tr_device <- paste("[", paste(train$device, collapse = ","), "]") %>% fromJSON(flatten = T)
# tr_geoNetwork <- paste("[", paste(train$geoNetwork, collapse = ","), "]") %>% fromJSON(flatten = T)
# tr_totals <- paste("[", paste(train$totals, collapse = ","), "]") %>% fromJSON(flatten = T)
# tr_trafficSource <- paste("[", paste(train$trafficSource, collapse = ","), "]") %>% fromJSON(flatten = T)
# 
# train <- train %>%
#   cbind(tr_device, tr_geoNetwork, tr_totals, tr_trafficSource) %>%
#   select(-device, -geoNetwork, -totals, -trafficSource)
# sapply(train, class)
# 
# 
# 
# 
# 
# jsonCol<-input_data[,c(3,5,8,9)]
# df <- flatten(jsonCol)
# 
# str(df)
# 
# column1<-as.character(input_data[,3])
# column2<-as.character(input_data[,5])
# column3<-as.character(input_data[,8])
# column4<-as.character(input_data[,9])
# 
# 
# 
# 
# 
# column1<-column1 %>%             
#   as.tbl_json %>%  
# 
#   spread_values(   
#      browserVersion = jstring("browserVersion"),    
#      browserSize =  jstring("browserSize"),
#      operatingSystem = jstring("operatingSystem"),
#     opSysVer = jstring("operatingSystemVersion"),
#     isMobile = jlogical("isMobile"),
#      mobileBrand = jstring("mobileDeviceBranding"),
#      mobileModel = jstring("mobileDeviceModel"),
#      mobileInput = jstring("mobileInputSelector"),
#      mobileDevice = jstring("mobileDeviceInfo"),
#      mobileDeviceMarket = jstring("mobileDeviceMarketingName"),
#      flashVersion = jstring("flashVersion"),
#      language = jstring("language"),
#      colors = jstring("screenColors"),
#      res = jstring("screenResolution"),
#      category = jstring("deviceCategory")
# 
# 
#   )%>%
#    select(-document.id)
# 
#  column2<-column2 %>%             
#    as.tbl_json %>%  
#    spread_values( 
#      continent = jstring("continent"),
#      subContinent = jstring("subContinent"),
#      country = jstring("country"),
#      region = jstring("region"),
#      metro = jstring("metro"),
#      city = jstring("city"),
#      cityID = jstring("cityID"),
#      networkDomain = jstring("networkDomain"),
#      latitude = jstring("latitude"),
#      longitude = jstring("longitude"),
#      networkLocation = jstring("networkLocation")
# 
#    )%>%
#    select(-document.id)
# 
# 
#  column3<-column3 %>%             
#    as.tbl_json %>%  
#    spread_values( 
#      visits = jnumber("visits"),
#      hits = jnumber("hits"),
#      pageviews = jnumber("pageviews"),
#      bounces = jnumber("bounces"),
#      newVisits = jnumber("newVisits")
#    )%>%
#    select(-document.id)
# 
# 
# 
#  column4<-column4 %>%             
#    as.tbl_json %>%  
#    spread_values( 
#      campaign = jstring("campaign"),
#      source = jstring("source"),
#      medium = jstring("medium"),
#      keyword = jstring("keyword")
#      
#   )%>%
#    select(-document.id)
# 
# 
#  corrected_json<-data.frame(column1,column2,column3, column4)
#  train1<-data.frame(regCol, corrected_json)