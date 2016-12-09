#---------------------------------------------------------------------------------------------------
#
# Outlier Detection with Mahalanobis Distance
#
#---------------------------------------------------------------------------------------------------

# Load libraries
library(ggplot2)
library(dplyr)

# Set color palette
cbPalette <- c("#999999", "#4288D5", "#E69F00", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

# Example Data
df <- read.csv("weight_height.csv")
df <- rename(df, height = ï..height)     # Rename height feature
df$outlier_th <- "No"

# Histograms
ggplot(df, aes(x = weight)) + geom_histogram()
ggplot(df, aes(x = height)) + geom_histogram()

# Scatterplot
ggplot(df, aes(x = weight, y = height, color = outlier_th)) +
      geom_point(size = 5, alpha = 0.6) +
      labs(title = "Height - Weight Scatterplot",
           subtitle = "2500 Data Points of height (cm) and weight (kg)",
           caption = "Source: http://wiki.stat.ucla.edu/socr/index.php/SOCR_Data_Dinov_020108_HeightsWeights") +
      ylab("Height in cm") + xlab("Weight in kg") +
      scale_y_continuous(breaks = seq(160, 200, 5)) +
      scale_x_continuous(breaks = seq(35, 80, 5)) +
      scale_colour_manual(values=cbPalette)

# Add "Abnormality" Features
df$outlier_th[(df$weight < 41) | (df$weight > 72)] <- "Yes"
df$outlier_th[(df$height > 187) | (df$height < 160)] <- "Yes"

# Scatterplot showing Outliers itentified by feature thresholds
ggplot(df, aes(x = weight, y = height, color = outlier_th)) +
      geom_point(size = 5, alpha = 0.6) +
      labs(title = "Weight vs Height",
           subtitle = "Outlier Detection in weight vs height data with Feature Thresholds",
           caption = "Source: http://wiki.stat.ucla.edu/socr/index.php/SOCR_Data_Dinov_020108_HeightsWeights") +
      ylab("Height in cm") + xlab("Weight in kg") +
      scale_y_continuous(breaks = seq(160, 200, 5)) +
      scale_x_continuous(breaks = seq(35, 80, 5)) +
      geom_vline(xintercept = 41, linetype = "dotted") + 
      geom_vline(xintercept = 72, linetype = "dotted") +
      geom_hline(yintercept = 160, linetype = "dotted") +
      geom_hline(yintercept = 187, linetype = "dotted") +
      scale_colour_manual(values=cbPalette)

# Calculate Mahalanobis
m_dist <- mahalanobis(df[, 1:2], colMeans(df[, 1:2]), cov(df[, 1:2]))
df$m_dist <- round(m_dist, 2)

# Mahalanobis Distance Histogram
ggplot(df, aes(x = m_dist)) +
      geom_histogram(bins = 50) +
      labs(title = "Mahalanobis Distances",
           subtitle = "Histogram based on Mahalanobis Distances for Weight + Height",
           caption = "Source: http://wiki.stat.ucla.edu/socr/index.php/SOCR_Data_Dinov_020108_HeightsWeights") +
      xlab("Mahalanobis Distance") +
      scale_y_continuous(breaks = seq(0, 700, 100))

# Maha Outliers
df$outlier_maha <- "No"
df$outlier_maha[df$m_dist > 12] <- "Yes"

# Scatterplot with Maha Outliers
ggplot(df, aes(x = weight, y = height, color = outlier_maha)) +
      geom_point(size = 5, alpha = 0.6) +
      labs(title = "Weight vs Height",
           subtitle = "Outlier Detection in weight vs height data - Using Mahalanobis Distances",
           caption = "Source: http://wiki.stat.ucla.edu/socr/index.php/SOCR_Data_Dinov_020108_HeightsWeights") +
      ylab("Height in cm") + xlab("Weight in kg") +
      scale_y_continuous(breaks = seq(160, 200, 5)) +
      scale_x_continuous(breaks = seq(35, 80, 5)) +
      scale_colour_manual(values=cbPalette)

# Outliers removed
df2 <- df %>%
      filter(m_dist < 12)

ggplot(df2, aes(x = weight, y = height, color = outlier_maha)) +
      geom_point(size = 5, alpha = 0.6) +
      labs(title = "Weight vs Height",
           subtitle = "Outlier Detection in weight vs height data - Using Mahalanobis Distances",
           caption = "Source: http://wiki.stat.ucla.edu/socr/index.php/SOCR_Data_Dinov_020108_HeightsWeights") +
      ylab("Height in cm") + xlab("Weight in kg") +
      scale_y_continuous(breaks = seq(160, 200, 5)) +
      scale_x_continuous(breaks = seq(35, 80, 5)) +
      scale_colour_manual(values=cbPalette) +
      geom_smooth(method = "lm", se = FALSE, color = "red")


