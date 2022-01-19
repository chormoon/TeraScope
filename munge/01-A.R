# The first preprocessing script.


#De-duplication of data
applicationCheckpoints = unique(application_checkpoints)
gpuNew = unique(gpu)
x_y_New = unique(task_x_y)


# Create a new data frame to compute the task runtimes.
# change time to hms format

applicationCheckpoints[,"timestamp"] = hms(substr(applicationCheckpoints$timestamp,12,23))
# We need eventName eventType timestamp 

# install.packages("hms")
# library(hms)

Durations = applicationCheckpoints %>%
  pivot_wider( 
    names_from = eventType,
    values_from = timestamp
  )
# Create a new feature called duration.
Durations[,"duration"] = as.duration(Durations$STOP - Durations$START)
Durations

#We do not need the start and stop now
DurationsNew = Durations[,-5]
DurationsNew = DurationsNew[,-5]
DurationsNew

#Create new col for task name and value for duration.
DurationsNew = DurationsNew%>%
  pivot_wider(
    # Create new columns based on values of eventName
    names_from = eventName,
    # Fill the duration for each event name
    values_from = duration
    
  )
DurationsNew
