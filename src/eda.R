library('ProjectTemplate')
library(hms)
library(dplyr)
load.project()

# Pre analysis
# Count the hostname for each data set
# The application checkpoint data
length(unique(application_checkpoints$hostname))
# The gpu data
length(unique(gpu$hostname))
# Check whether both data set the hostname is the same using the setequal function of dplyr
setequal(unique(application_checkpoints$hostname),unique(gpu$hostname))
# So the hostname are indeed the same


# Q1: Which event types dominate task runtimes?
head(DurationsNew,1)
Total_Tiling_time = sum(DurationsNew$Tiling)
Total_Saving_time = sum(DurationsNew$`Saving Config`)
Total_Render_time = sum(DurationsNew$Render)
Total_Uploading_time = sum(DurationsNew$Uploading)
# Set the x_axis and y_axis.
y_duration = c(Total_Tiling_time,Total_Render_time,Total_Saving_time,Total_Uploading_time)
x_duration = c('Total_Tiling_time','Total_Render_time','Total_Saving_time','Total_Uploading_time')
# plot the bar chart
barplot(height = y_duration,
        names.arg = x_duration,
        col = 'orange',
        border = '#ffffff')
# It is obviously render dominate task runtimes




# Q2: What is the interplay between GPU temperature and performance?
attach(gpu_Q2) #set the dataset
plot(gpuTempC, powerDrawWatt , main="Temp and Power", 
     xlab="GPU Temp", ylab="GPU Power ", pch=19) #绘图
# Add fit lines

abline(lm(powerDrawWatt~gpuTempC), col="red") # 添加拟合线，这里lm()是一个线性回归函数
lines(lowess(gpuTempC,powerDrawWatt), col="blue") # LOWESS（局部加权散点图平滑化）