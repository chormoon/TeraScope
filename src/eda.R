library('ProjectTemplate')
load.project()

# Pre analysis
# Count the hostname for each data set
# The application checkpoint data
length(unique(application_checkpoints$hostname))
# The gpu data
length(unique(gpu$hostname))
# Check whether both data set the hostname is the same using the setequal function of dplyr
setequal(unique(application.checkpoints$hostname),unique(gpu$hostname))
# So the hostname are indeed the same


# Which event types dominate task runtimes?
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