# Figure1F-J
# Reproduce subplots F-J from figure 1.

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

# change to wherever you are running this script from
readDir <-"C:/Users/cmanuel/Desktop"
setwd(readDir)

# Load data
DF_pupilSize <- read.csv("DF_pupilSize.csv")
DF_SpectralSlope <- read.csv("DF_SpectralSlope.csv")
DF_HeartRate <- read.csv("DF_HeartRate.csv")
DF_PupilvsSlope <- read.csv("DF_PupilvsSlope.csv")
DF_HeartRatevsSlope <- read.csv("DF_HeartRatevsSlope.csv")

sleepStateColors = c("#F4E285", "#ADA9B7", "#5B8E7D", "#464D77", "#F4A259") 
sleepStateColorsV2 = c("#000000", "#F4E285", "#ADA9B7", "#5B8E7D", "#464D77", "#F4A259") 


# Figure 1F (Pupil Size) ##############################################
lp <- ggplot(DF_pupilSize, aes(sleepState, pupilSize, colour = Participant))
lp + 
  stat_summary(fun.y = mean, geom = "point", aes(group= Participant), colour="gray", size=1) + 
  stat_summary(fun.y = mean, geom = "line", aes(group= Participant), colour="gray", size=1) +
  stat_summary(fun.y=mean, geom="line", aes(group=1), colour="black", size=2) +
  stat_summary(fun.y=mean, geom="point", aes(group=1), colour=sleepStateColors, size=6)+
  labs(x = "", y = "Pupil Size (arb. units)") +
  scale_x_discrete(labels = c("W", "N1", "N2", "N3", "R"))+
  ylim(0.2, 0.7) + 
  theme_light(base_size = 20)+
  theme(legend.position = "none")+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))

# Figure 1G (Spectral Slope) ##############################################
lp <- ggplot(DF_SpectralSlope, aes(sleepStage, slope, colour = Participant))
lp + 
  stat_summary(fun.y = mean, geom = "point", aes(group= Participant), colour="gray", size=1.5) + 
  stat_summary(fun.y = mean, geom = "line", aes(group= Participant), colour="gray", size=1) +
  stat_summary(fun.y=mean, geom="line", aes(group=1), colour="black", size=2) +
  stat_summary(fun.y=mean, geom="point", aes(group=1), colour=sleepStateColors, size=6)+
  labs(x = "", y = "Spectral Slope (arb. units)") +
  scale_x_discrete(labels = c("W", "N1", "N2", "N3", "R"))+
  scale_y_continuous(breaks = seq(-7, 1, by=1), limits=c(-7, 1)) +
  theme_light(base_size = 20)+
  theme(legend.position = "none")+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))


# Figure 1H (Heart Rate) ##############################################
lp <- ggplot(DF_HeartRate, aes(sleepState, HR, colour = Participant))
lp + 
  stat_summary(fun.y = mean, geom = "point", aes(group= Participant), colour="gray", size=1.5) + 
  stat_summary(fun.y = mean, geom = "line", aes(group= Participant), colour="gray", size=1) +
  stat_summary(fun.y=mean, geom="line", aes(group=1), colour="black", size=2) +
  stat_summary(fun.y=mean, geom="point", aes(group=1), colour=sleepStateColors, size=6) +
  labs(x = "", y = "Heart Rate (BPM)") +
  scale_x_discrete(labels = c("W", "N1", "N2", "N3", "R"))+
  theme_light(base_size = 20)+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))

# Figure 1I (Pupil size vs spectral slope) ####
ggplot(DF_PupilvsSlope, aes(x = sleepStage, y = R, fill = sleepStage, group = 1)) +
  geom_errorbar(aes(ymin = CIlower, ymax = CIupper),
                width = 0.2, color = "black", size = 0.8) +
  stat_summary(fun.y = mean, geom = "line",colour="black", size=1) +
  stat_summary(fun.y = mean, geom = "point", colour = sleepStateColorsV2,  size=7) + 
  labs(x = "", y = "Spectral Slope vs. Pupil Size (R)") +
  ylim(-0.1,0.4) +
  theme(panel.grid = element_blank())+
  theme_light(base_size = 16)+
  geom_hline(yintercept = 0, color = "black", linetype = "solid") +  # Horizontal black line at y=5
  theme(legend.position = "none")+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))

# Figure 1J (Heart Rate vs spectral slope) ####
ggplot(DF_HeartRatevsSlope, aes(x = sleepStage, y = R, fill = sleepStage, group = 1)) +
  geom_errorbar(aes(ymin = CIlower, ymax = CIupper),
                width = 0.2, color = "black", size = 0.8) +
  stat_summary(fun.y = mean, geom = "line",colour="black", size=1) +
  stat_summary(fun.y = mean, geom = "point", colour = sleepStateColorsV2,  size=7) + 
  labs(x = "", y = "Spectral Slope vs Heart Rate (R)") +
  ylim(-0.1,0.3) +
  theme(panel.grid = element_blank())+
  theme_light(base_size = 16)+
  geom_hline(yintercept = 0, color = "black", linetype = "solid") +  # Horizontal black line at y=5
  theme(legend.position = "none")+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))
