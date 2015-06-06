rawdata <-read.table("household_power_consumption.txt", sep=";", header=TRUE,colClasses="character")
  # read data from the txt file and coerce data into characters

RawDataDT <- transform(rawdata,Date=as.Date(Date,"%d/%m/%Y"))
 # assign class date to the Date column

subdata <- subset(RawDataDT, Date >= as.Date("2007-02-01") & Date<= as.Date("2007-02-02"))
 # subsets the data as we only need these 2 days of observations

TyData <- subdata
TyData[,seq(3,9)] <- sapply(subdata[,seq(3,9)],as.numeric)
  #coerces column 3 to 9 into numeric type

hist(TyData$Global_active_power,col="Red",main="Global Active Power", xlab="Global Active Power (kilowatts)")
  #creates histogram
dev.copy(png, file="plot1.png") # copies the plot into png file
dev.off() #closes the png device.

