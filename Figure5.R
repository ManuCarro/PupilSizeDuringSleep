# Figure5
# Reproduce subplots from figure 5.

# Authors with email: Manuel Carro Dominguez 
#                     (manuel.carrodominguez@hest.ethz.ch)
# Date of creation: 14.12.2024 
# Copyright: (c) 2024. MANUEL CARRO DOMINGUEZ, 
#               Neural Control of Movement Lab, ETH Zurich. All rights reserved

# Clear plots
if(!is.null(dev.list())) dev.off()
# Clean workspace
rm(list=ls())
# Clear console
cat("/014")

library(ggplot2) # graphs

# change readDir to wherever you are running this script from
readDir <-"C:/Users/cmanuel/Desktop"
setwd(readDir)

# Load data
DF_Figure5sigma <- read.csv("DF_Figure5sigma.csv")
DF_Figure5delta <- read.csv("DF_Figure5delta.csv")


# Figure 5A (Sigma Power) ##############################################
lp <- ggplot(DF_Figure5sigma, aes(StimTime, sigma, label=Participant))

lp + 
  stat_summary(fun.y = mean, geom = "point", aes(group= Participant), colour="gray", size=1.5) + 
  stat_summary(fun.y = mean, geom = "line", aes(group= Participant), colour="gray", size=1) +
  stat_summary(fun.y=mean, geom="line", aes(group=1), colour="black", size=2) +
  stat_summary(fun.y=mean, geom="point", aes(group=1), colour="black", size=3)+
  labs(x = "", y = "Sigma Power (uV^2)") +
  geom_text(aes(label = ifelse(StimTime == "bStimEarly", Participant, "")), hjust = -0.75, size=3, colour="gray")+
  theme_light(base_size = 12)+
  theme(panel.grid = element_blank(), legend.position = "none") +
  facet_grid(~pupilRange)


# Figure 5B (Delta Power) ##############################################
lp <- ggplot(DF_Figure5delta, aes(StimTime, delta, label=Participant))

lp + 
  stat_summary(fun.y = mean, geom = "point", aes(group= Participant), colour="gray", size=1.5) + 
  stat_summary(fun.y = mean, geom = "line", aes(group= Participant), colour="gray", size=1) +
  stat_summary(fun.y=mean, geom="line", aes(group=1), colour="black", size=2) +
  stat_summary(fun.y=mean, geom="point", aes(group=1), colour="black", size=3)+
  labs(x = "", y = "Delta Power (uV^2)") +
  geom_text(aes(label = ifelse(StimTime == "bStimEarly", Participant, "")), hjust = -0.75, size=3, colour="gray")+
  theme_light(base_size = 12)+
  theme(panel.grid = element_blank(), legend.position = "none") +
  facet_grid(~pupilRange)

