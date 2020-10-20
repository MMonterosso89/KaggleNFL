library(tidyverse)
library(lubridate)
library(data.table)


#Just starting with first few weeks - Kaggle API 3.0 seems only kitted out for Python and just DLing to start will be quicker

path <- "C:\\Users\\Matth\\Desktop\\SelfTeach\\KaggleNFL\\Data\\"

list.files(path)


for (file in list.files(path)){
  assign(paste0(sub(".csv","", file),"_df"), fread(paste0(path,file)))
}


#Just starting with first few weeks - Kaggle API 3.0 seems only kitted out for Python and just DLing to start will be quicker



games_df$Home_x_Visit <- paste0(games_df$homeTeamAbbr," x ",games_df$visitorTeamAbbr)


players_df$BirthYear <- str_extract(players_df$birthDate,"\\d{4}")



##players getting bigger? Not really

ggplot(players_df %>% filter(position == "QB"), aes(x = BirthYear, y = weight, color = as.factor(position))) +
  geom_point()


ggplot(players_df, aes(x = weight, fill = as.factor(position))) +
  geom_histogram()


ggplot(players_df, aes(x = weight, fill = as.factor(position))) +
  geom_density()



single_game_single_play_df <- week1_df %>%
  filter(gameId == "2018090600" & playId == "75")


ggplot(single_game_single_play_df, aes(x = x, y = y, size = s, color = displayName, shape = team)) +
  geom_point() +
  scale_size_continuous(limits = c(0,10)) + 
  scale_x_continuous(limits = c(0,120), breaks = c(10,20,30,40,50,60,70,80,90,100,100,110,120)) +
  scale_y_continuous(limits = c(0,53.3))



######try animate

#install.packages("gganimate")

#install.packages(c("gifski", "av"))

library(gganimate)

# 
# plot <- ggplot(single_game_single_play_df, aes(x = x, y = y, size = s, color = displayName, shape = team, alpha = 0.15)) +
#   geom_point()
# 
# 
# plot
# 
# anim <- plot + 
#   transition_states(frameId,
#                     transition_length = 2,
#                     state_length = 3)
# 
# 
# anim
# 
# 
# 
# anim_save(paste0(path,"animtest.gif"), animation = last_animation())


##v2 - each frame is 100ms


plot2 <- ggplot(single_game_single_play_df, aes(x = x, y = y, size = s, color = team, shape = team)) +
  geom_point()


plot2

anim2 <- plot2 + 
  transition_states(frameId,
                    
                    state_length = 5) +
                    shadow_wake(wake_length = 1, alpha = FALSE)  + 
  ggtitle('Current time in Play Time {frame}')



anim2


animate(anim2, nframes = length(unique(single_game_single_play_df$frameId)) * 0.1 * 144, fps = 144, duration = 5.9, width = 800, height = 800/2.25)


anim_save("C:\\Users\\Matth\\Desktop\\SelfTeach\\KaggleNFL\\animhighfps.gif", animation = last_animation())

##not a 5.9 second gif...


##transition states is not correct function I don't think - we aren't going through states but a cont play

gganimate::transition_time()
