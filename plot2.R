#downloading and unziping raw data
data_folder <- "data"
zip_file_name <- paste0(data_folder,"/","household_power_consumption.zip")
data_src_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists(data_folder)){
  dir.create(data_folder)
}
if(!file.exists(zip_file_name)){
  download.file(data_src_url, zip_file_name)  
}

unzip(zipfile = zip_file_name, exdir = data_folder)

#loading the hpc_data into memory and casting Date and Time as Date and Time in r
dateformat <- "%d/%m/%Y"
timeformat <- "%H:%M:%S"
hpc_data <- read.table(paste0(data_folder,"/household_power_consumption.txt"),sep=";",header=TRUE, na.strings=c("?"))
hpc_data$Date <- as.Date(hpc_data$Date,format=dateformat)
hpc_data$Time<-strptime(hpc_data$Time, format=timeformat)

#subsetting the data by date >= 2007-02-01  and date <= 2007-02-02
hpc_data <- hpc_data[which((hpc_data$Date >=as.Date("2007-02-01")) & (hpc_data$Date <= as.Date("2007-02-02"))),]

#Creating the plot with base plotting
with(hpc_data,{
  
  #open the png file
  png("plot2.png", width = 480, height = 480)
  
  #create the plot
  plot(as.POSIXct(paste(Date,format(Time,"%H:%M:%S")),format("%Y-%m-%d %H:%M:%S")),
       Global_active_power,
       ylab="Global Active Power (kilowatts)",
       xlab="",
       main="Global Active Power", 
       type="l")
  
  #close the device
  dev.off()
})


