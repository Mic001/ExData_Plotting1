rawdata <-read.table("household_power_consumption.txt", sep=";", header=TRUE,colClasses="character")
  # read data from the txt file and coerce data into characters

RawDataDT <- transform(rawdata,Date=as.Date(Date,"%d/%m/%Y"))
 # assign class date to the Date column.

subdata <- subset(RawDataDT, Date >= as.Date("2007-02-01") & Date<= as.Date("2007-02-02"))
 # subsets the data as we only need these 2 days of observations

TyData <- subdata #copies the subdata to a new Data Frame for further coercion.
TyData[,seq(3,9)] <- sapply(subdata[,seq(3,9)],as.numeric)
  #coerces column 3 to 9 into numeric type

TyData$DT <- as.POSIXlt(paste(subdata$Date,subdata$Time),
format="%Y-%m-%d %H:%M:%S")
  #creates a date-time column by combining date and time together

par(mfcol=c(2,2)) 
par(cex=0.65)
  #set up the format of the graphic area i.e. matrix 2x2 filled by column

plot(TyData$DT,TyData$Global_active_power,type="n",xlab="",ylab="Global Active Power (kilowatts)",main="")
lines(TyData$DT,TyData$Global_active_power)
# plot1 (top left)

plot(TyData$DT,TyData$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering",main="")
lines(TyData$DT,TyData$Sub_metering_1, col="black")
lines(TyData$DT,TyData$Sub_metering_2, col="red")
lines(TyData$DT,TyData$Sub_metering_3, col="blue")
legend("topright",lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub-metering_2","Sub_metering_3"))
  # plot2 (bottom left)
  
plot(TyData$DT,TyData$Voltage,type="n",xlab="datetime",ylab="Voltage")
lines(TyData$DT,TyData$Voltage)
  # plot3 (top right)

plot(TyData$DT,TyData$Global_reactive_power,type="n",xlab="datetime",ylab="Global_reactive_power")
lines(TyData$DT,TyData$Global_reactive_power)
  # plot4 (bottom right)

dev.copy(png, file="plot4.png") # copies the plot into png file
dev.off() #closes the png device.