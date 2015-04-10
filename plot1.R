library(data.table)
#read the file
DT <- fread("household_power_consumption.txt",header=TRUE, sep=";"
            ,na.strings="?" )

#Subset the data we want
FILTERED_DT <- DT[DT$Date=="1/2/2007" | DT$Date=="2/2/2007",]

#Add a datetime column
FILTERED_DT$DateTime <- as.POSIXct(paste(FILTERED_DT$Date, 
                         FILTERED_DT$Time), format="%d/%m/%Y %H:%M:%S")

# open the png graphics device
png(filename = "plot1.png", width=480, height=480)

#Draw the histogram
hist(as.numeric(FILTERED_DT$Global_active_power), main="Global Active Power",
     xlab="Global Active Power (kilowatts) ", col="red")

#close the PNG device
dev.off()
