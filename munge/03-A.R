# data for Q5R
# calculate the duration time for each gpu
duration_time_list = c()
for(i in c_hostname){
  applicationCheckpoints_duration = applicationCheckpoints[which(applicationCheckpoints$hostname==i),]
  applicationCheckpoints_duration = arrange(applicationCheckpoints_duration,'timestamp')
  application_nrow = nrow(applicationCheckpoints_duration)
  duration_time = applicationCheckpoints_duration[application_nrow,1]-applicationCheckpoints_duration[1,1]
  duration_time = as.duration(duration_time$timestamp)
  duration_time_list = c(duration_time_list, duration_time)
}
duration_time_total = cbind( c_hostname, duration_time_list)
duration_time_total

#cbind with total render time
DurationsNew
Total_Render_time_avg_host

efficiency = cbind(duration_time_total,Total_Render_time_avg_host)
efficiency = as.data.frame(efficiency)
efficiency = efficiency[,-3]
efficiency
efficiency = mutate(efficiency, efficiency_duration = as.numeric(Total_Render_time_avg) / as.numeric(duration_time_list))
efficiency = arrange(efficiency,efficiency$efficiency_duration)
