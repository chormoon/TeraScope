library('ProjectTemplate')
library(hms)
library(dplyr)
library(tidyr)
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
library(ggplot2)
# power and temp
p01=ggplot(
       data=data_power_temp, # set data
       mapping=aes( 
             x=c_temp, 
             y=power_avg,
             color= power_avg
         )
   )
p01+geom_point()+theme_bw()+geom_smooth(method="lm",colour= "orange" )+scale_color_gradient(low = "pink", high = "red")

# gpuUtilPerc and temp
p02=ggplot(
  data=data_gpuUtilPerc_temp, # set data
  mapping=aes( 
    x=c_temp, 
    y=gpuUtilPerc_avg,
    color=gpuUtilPerc_avg
  )
)
p02+geom_point()+theme_bw()+geom_smooth(method="lm",colour= "orange" )+scale_color_gradient(low = "pink", high = "red")

# gpuMemUtilPerc and temp
p03=ggplot(
  data=data_gpuMemUtilPerc_temp, # set data
  mapping=aes( 
    x=c_temp, 
    y=gpuMemUtilPerc_avg,
    color=gpuMemUtilPerc_avg
  )
)
p03+geom_point()+theme_bw()+geom_smooth(method="lm",colour= "orange" )+scale_color_gradient(low = "pink", high = "red")
# So the GPU temperature is proportional to performance 


# Q3: What is the interplay between increased power draw and render time?
#     Can we quantify the variation in computation requirements for particular tiles?
length(DurationsNew$taskId)# 65793
length(unique(DurationsNew$taskId))# 65793
# So we can use taskId to analysis.

length(DurationsNew$hostname)# 65793
length(unique(DurationsNew$hostname))# 1024
# So we can use taskId to analysis.

length(gpuNew$timestamp)# 1543672
length(unique(gpuNew$timestamp))# 1208802
# So we can not use timestamp to analysis.

length(gpuNew$hostname)# 1543672
length(unique(gpuNew$hostname))# 1024
# So we can not use hostname to analysis.

length(gpuNew$gpuUUID)# 1543672
length(unique(gpuNew$gpuUUID))# 1208802
# So we can not use timestamp to analysis.

# Finally I decide to use the hostname as a distinction and compute the avg of the power and render.
head(avg_power_render)
p04=ggplot(
  data=avg_power_render, # set data
  mapping=aes( 
    x=avg_power_list, 
    y=as.numeric(avg_render_list),
    color=as.numeric(avg_render_list)
  )
)
p04+geom_point()+theme_bw()+geom_smooth(method="lm",colour= "orange" )+scale_color_gradient(low = "pink", high = "red")




# Q4: Can we identify particular GPU cards (based on their serial numbers) whose performance differs to other cards? (i.e. perpetually slow cards).