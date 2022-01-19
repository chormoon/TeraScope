# Set data for quesiont 2
head(gpuNew)
# We only need  powerDrawWatt gpuTempC gpuUtilPerc gpuMemUtilPerc
gpu_Q2 = gpuNew[,5:8]
gpu_Q2
# reorder the data
library(dplyr)
gpu_Q2 = arrange(gpu_Q2 , gpu_Q2$gpuTempC)

