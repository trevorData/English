setwd("~/Projects/English")

library(tidyr)
library(ggplot2)
library(ggrepel)

raw.df <- read.csv('english.csv')

# Limit to countries with over 300k english speakers
df <- raw.df[raw.df$english_total > 300000,]
df$english_first <- df$english_first %>% replace_na(0)

df$total_per <- df$english_total/df$pop
df$first_per <- df$english_first/df$pop

# Limit to countries with greater than 1% speaking English as a first language
df <- df[(df$first_per > .01),]

ggplot(df) + 
  geom_point(aes(total_per, first_per, size=pop), color='coral2') +
  geom_text_repel(aes(label = country, total_per, first_per), 
                  size=3.2, force=2, point.padding = .2, 
                  box.padding = .3, nudge_x = .02) +
  xlab("English Speakers (%)") + 
  ylab("English as First Language (%)") +
  scale_size_continuous(range = c(2,7)) +
  scale_y_continuous(breaks = c(0, .5, 1), 
                     labels = c('0', '50', '100'), 
                     limits = c(0,1)) +
  scale_x_continuous(breaks = c(0, .5, 1), 
                     labels = c('0', '50', '100'), 
                     limits = c(0,1)) +
  theme_classic() +
  theme(legend.position = 'none')
