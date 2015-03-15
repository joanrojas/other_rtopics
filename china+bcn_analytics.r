#Plotting a decent line graph
library(dplyr)
library(ggplot2)
library(BcnDataAccess)

#CHINA DATASET------------------------------
df.china_co2 <- read.csv(url("http://www.sharpsightlabs.com/wp-content/uploads/2015/01/china_co2_1961_to_2010_data.txt"))
china_co2 <- tbl_df(df.china_co2)
View(china_co2)
#This code snippet produces a line plot but it can be improved A LOT.
china_co2 %>%
  ggplot(aes(x = year, y = co2_emission_per_cap_qt)) +
  geom_line()

#Some things that come to my mine are: 
#I want to know where my data points are exactly (from which years)
#I want to change the axis titles and give a title to the plot
china_co2 %>%
  ggplot(aes(x = year, y = co2_emission_per_cap_qt)) +
  geom_line(color = "steelblue", size = 1) +
  geom_point(color = "steelblue", size = 3) + 
  ggtitle("Evolution of CO2 emissions") + 
  labs(x = "Year", y= "Emission per capita") + 
  theme(plot.title = element_text(color = "black", size = 20, face = "bold", family = "Arial"))

#PROJECT BCN ANALYTICS. A FIRST LOOK

dd <- BcnDataSources$OpenData$DemografiquesSeccioCensal$getData()
data_bcn <- tbl_df(dd)
names(data_bcn)
class(data_bcn)
View(data_bcn)
#Looks like seccio censal refers to some sort of share of the bcn territory

data_bcn %>%
  ggplot(aes(x = HOMES)) + 
  geom_histogram(binwidth = 20) +






