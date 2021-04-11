#Workshop: R fundamentals - Part 5: Basic plots
#Author: Denisse Fierro Arcos
#Date of creation: 2021-04-11
#Details: 
#In this script we show how to create basic plots with ggplots

# Loading libraries -------------------------------------------------------
#We will call libraries that are relevant to this script
library(tidyverse)
library(stringi)

# Loading data from the web -----------------------------------------------
#You can use R to access datasets available online
#We will access data about deforestation around the world, which available through TidyTuesday
#https://github.com/rfordatascience/tidytuesday/blob/master/data/2021/2021-04-06/readme.md 
forest <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-04-06/forest.csv') %>% 
  glimpse()


# Data manipulation -------------------------------------------------------
#Let's change the entity and code columns into factors
forest <- forest %>% 
  #We can see that these columns are characters, so we can choose to change
  #the character columns into factors
  mutate_if(is.character, factor)

#Checking the result
forest %>% 
  glimpse()

#Let's check if Australia and New Zealand are contained in this data set
forest %>% 
  #We can get the unique values under entity 
  distinct(entity)%>% 
  #Get them as a string
  pull() %>% 
  #Check if Australia, New Zealand and Papua New Guinea appear in the list of unique values
  stri_detect_regex(paste("Australia", "New Zealand", "Papua New Guinea", sep = "|"))

forestAusNewPNG <- forest %>% 
  filter(stri_detect_regex(.$entity, 
                           paste("Australia", "New Zealand",  "Papua New Guinea", 
                                 sep = "|")))
#Checking results
forestAusNewPNG
#We can see that there are less values for Australia than the other two countries

#We can fix this with the complete() function
forestAusNewPNG <- forestAusNewPNG %>% 
  complete(year, nesting(entity, code)) %>%
  #Finally we will change the name of the column entity to country
  rename(Country = entity)

#Checking results
forestAusNewPNG

# Plotting ----------------------------------------------------------------
#We will create a basic plot with the new data frame
forestAusNewPNG %>% 
  #Calling ggplot, setting x and y axes
  ggplot(aes(x = Country, y = net_forest_conversion))+
  #Choosing type of plot to be used
  geom_bar(stat = "identity")
#This does look great

#We will improve it by changing the color of each year
forestAusNewPNG %>% 
  ggplot(aes(x = Country, y = net_forest_conversion, fill = year))+
  geom_bar(stat = "identity")
#Still not great

#We will separate each year column
forestAusNewPNG %>% 
  #We include year as a way of grouping the data 
  ggplot(aes(x = Country, y = net_forest_conversion, fill = year, group = year))+
  geom_bar(stat = "identity", position = position_dodge())
#It is looking a little better now, but how do we change the colour bar

#We can change the year into factors so it recognises them as distinct groups
forestAusNewPNG %>% 
  mutate(year = as.factor(year)) %>% 
  #We include year as a way of grouping the data
  #We can even perform calculations prior to plotting data
  ggplot(aes(x = Country, y = net_forest_conversion/1000, fill = year, group = year))+
  #We can add a black line around each column
  geom_bar(stat = "identity", position = position_dodge(), col = "black")+
  #We can change the colour palette for one that show qualitative data
  scale_fill_brewer(type = "qual")+
  #We can remove the background by applying a new theme
  theme_bw()+
  #We can change the axes and legend labels, and add a title
  labs(y = "Net forest conversion (x1000 Ha)", fill = "Year", 
       title = "Five-yearly net forest conversion in Australia, NZ and PNG")
  
#If we prefer, we could also plot changes for each five-year period in a different graph
forestAusNewPNG %>% 
  mutate(year = as.factor(year)) %>% 
  #This time we will color each bar differently based on the country
  ggplot(aes(x = code, y = net_forest_conversion/1000, fill = Country))+
  #We can add a black line around each column
  geom_bar(stat = "identity", col = "black")+
  facet_wrap(~year)+
  #We can change the colour palette for one that show qualitative data
  scale_fill_brewer(type = "qual")+
  #We can remove the background by applying a new theme
  theme_bw()+
  #We can change the axes and legend labels, and add a title
  labs(y = "Net forest conversion (x1000 Ha)", fill = "Country", x = "", 
       title = "Five-yearly net forest conversion in Australia, NZ and PNG")+
  #We can also change the legend location
  theme(legend.position = "top", 
        #Remove the x axis labels and ticks 
        axis.text.x = element_blank(), axis.ticks.x = element_blank())+
  #As well as the location of the title within the legend
  guides(fill = guide_legend(title.position = "top", title.hjust = 0.5))

#You can save this plot using ggsave()
ggsave("DeforestationAusNzPNG.jpg", device = "jpg")
