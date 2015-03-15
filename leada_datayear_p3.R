#LEADA DATAYEAR Problem set 3
library(dplyr)
library(ggplot2)

data_raw <- read.csv("2008.csv.bz2", header = TRUE, nrows= 1000000)
data <- tbl_df(data_raw)
names(data)
View(data)
#The description of variables can be found at (http://stat-computing.org/dataexpo/2009/the-data.html)


#P1. Find the IATA code that is in the Origin column, but is NOT in the Dest column.
unique_origins <- mutate(unique(select(data,Origin)), comp = as.character(Origin)) %>% select(comp)
unique_dest <- mutate(unique(select(data,Dest)), comp = as.character(Dest)) %>% select(comp)
setdiff(unique_dest,unique_origins)
#The IATA_code is OGD


#P2. Problem 2:  Which airport, as defined by the IATA code, has at least 10,000
#flights and had the lowest probability for a delayed flight in the data?
data_ex2 <- data%>%
  filter(!is.na(ArrDelay), !is.na(DepDelay)) %>%
  mutate(Origin_Delay = ArrDelay > 0, Dest_Delay = DepDelay > 0)

origin <- data_ex2 %>%
  select(Airp = Origin, delay = Origin_Delay)
dest <- data_ex2 %>%
  select(Airp = Dest, delay= Dest_Delay) 

z <- rbind(origin,dest)
z_1 <- z %>%
  group_by(Airp) %>%
  summarise(tot_delay = sum(delay),n= n ()) %>%
  mutate(prob = tot_delay/n) %>%
  filter(n > 50000) %>%
  arrange(prob)

ggplot(z_1,aes(x = Airp, y =prob, size = n)) + geom_point() + scale_size_area() + 
theme(axis.text.x = element_text(angle = 90))
