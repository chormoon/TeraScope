# Set data for quesiont 2
head(gpuNew)
# We only need  powerDrawWatt gpuTempC gpuUtilPerc gpuMemUtilPerc
gpu_Q2 = gpuNew[,5:8]
gpu_Q2
# reorder the data
library(dplyr)
gpu_Q2 = arrange(gpu_Q2 , gpu_Q2$gpuTempC)



# 1. temp and power
c_temp = unique(gpu_Q2$gpuTempC)
power_avg = c()
for(i in c_temp){
    gpu_Q2_power_avgr = sum(gpu_Q2[which(gpu_Q2$gpuTempC == i),'powerDrawWatt'])/nrow(gpu_Q2[which(gpu_Q2$gpuTempC == i),'powerDrawWatt'])
    power_avg = c(power_avg,gpu_Q2_power_avgr)
}
# length(power_avg)
data_power_temp = cbind(c_temp,power_avg)
data_power_temp = as.data.frame(data_power_temp)

# 2. temp and gpuUtilperc
gpuUtilPerc_avg = c()
for(i in c_temp){
  gpu_Q2_gpuUtilPerc_avgr = sum(gpu_Q2[which(gpu_Q2$gpuTempC == i),'gpuUtilPerc'])/nrow(gpu_Q2[which(gpu_Q2$gpuTempC == i),'gpuUtilPerc'])
  gpuUtilPerc_avg = c(gpuUtilPerc_avg,gpu_Q2_gpuUtilPerc_avgr)
}
# length(c_temp)
# length(gpuUtilPerc_avg)
data_gpuUtilPerc_temp = cbind(c_temp,gpuUtilPerc_avg)
data_gpuUtilPerc_temp = as.data.frame(data_gpuUtilPerc_temp)
# data_gpuUtilPerc_temp



# 3. temp and gpuMemUtilPerc
gpuMemUtilPerc_avg = c()
for(i in c_temp){
  gpu_Q2_gpuMemUtilPerc_avgr = sum(gpu_Q2[which(gpu_Q2$gpuTempC == i),'gpuMemUtilPerc'])/nrow(gpu_Q2[which(gpu_Q2$gpuTempC == i),'gpuMemUtilPerc'])
  gpuMemUtilPerc_avg = c(gpuMemUtilPerc_avg,gpu_Q2_gpuMemUtilPerc_avgr)
}
# length(c_temp)
# length(gpuUtilPerc_avg)
data_gpuMemUtilPerc_temp = cbind(c_temp,gpuMemUtilPerc_avg)
data_gpuMemUtilPerc_temp = as.data.frame(data_gpuMemUtilPerc_temp)
# data_gpuMemUtilPerc_temp
