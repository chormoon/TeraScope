# Set data for quesiont 3
head(DurationsNew)
head(gpuNew)


#1. calculate the avg render for each hostname
c_hostname = unique(DurationsNew$hostname)
c_hostname
avg_render_list = c()
for(i in c_hostname){
  avg_render = sum(DurationsNew[which(DurationsNew$hostname == i),'Render'])/nrow(DurationsNew[which(DurationsNew$hostname==i),'Render'])
  avg_render_list = c(avg_render_list,avg_render)
}
avg_render_list
avg_host_render = cbind(c_hostname,avg_render_list)
avg_host_render


#2. calculate the avg power for each hostname
c_hostname = unique(gpuNew$hostname)
c_hostname
avg_power_list = c()
for(i in c_hostname){
  avg_power = sum(gpuNew[which(gpuNew$hostname == i),'powerDrawWatt'])/nrow(gpuNew[which(gpuNew$hostname==i),'powerDrawWatt'])
  avg_power_list = c(avg_power_list,avg_power)
}
avg_power_list
avg_host_power = cbind(c_hostname,avg_power_list)
avg_host_power

avg_power_render = left_join(as.data.frame(avg_host_render),as.data.frame(avg_host_power))
avg_power_render[,"avg_power_list"] = as.numeric(avg_power_render[,"avg_power_list"])
avg_power_render = arrange(avg_power_render,avg_power_render$avg_power_list)