library('ProjectTemplate')
load.project()

#Pre analysis
# Count the hostname for each data set
# The application checkpoint data
length(unique(application_checkpoints$hostname))
# The gpu data
length(unique(gpu$hostname))
# Check whether both data set the hostname is the same using the setequal function of dplyr
setequal(unique(application.checkpoints$hostname),unique(gpu$hostname))
# So the hostname are indeed the same

