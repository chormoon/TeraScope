# Set data for quesiont 4
head(gpuNew)
# calculate average Task Duration for Each GPU Seria
head(DurationsNew)

head(gpuNew)
check_gpu_host = c()
for(i in c_hostname){
  check_gpu_host = c(check_gpu_host, unique(gpuNew[which(gpuNew$hostname == i),"gpuSerial"]))
}
length(check_gpu_host)
check_gpu_host
# draw the total render time avg for each host
DurationsNew
Total_Render_time_avg = c()
for(i in c_hostname){
 Total_Render_time_avg = c(Total_Render_time_avg, sum(DurationsNew[which(DurationsNew$hostname==i),'TotalRender'])/length(DurationsNew[which(DurationsNew$hostname==i),'TotalRender']))  
}
Total_Render_time_avg_host = cbind(c_hostname,Total_Render_time_avg)
Total_Render_time_avg
Total_Render_time_avg_host

# draw the card for each host
head(gpuNew)
c_card = c()
for(i in c_hostname){
  c_card = c(c_card,as.numeric(unique(gpuNew[which(gpuNew$hostname==i),'gpuSerial'])))
}
c_card
c_card_host = cbind(c_hostname,c_card)
c_card_host
host_card = left_join(as.data.frame(Total_Render_time_avg_host),as.data.frame(c_card_host))
host_card = 



