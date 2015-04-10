library(data.table)
#read the file
DT <- fread("household_power_consumption.txt",header=TRUE, sep=";"
            ,na.strings="?" )

#Subset the data we want
FILTERED_DT <- DT[DT$Date=="1/2/2007" | DT$Date=="2/2/2007",]

#Add a datetime column
FILTERED_DT$DateTime <- as.POSIXct(paste(FILTERED_DT$Date, 
                                         FILTERED_DT$Time), 
                                   format="%d/%m/%Y %H:%M:%S")

# open the png graphics device
png(filename = "plot4.png", width=480, height=480)


# We want two rows and two columns for the plots
# Rows are populated first
par(mfrow = c(2, 2))

# Draw the Global Active Power plot
with(FILTERED_DT,plot(DateTime,Global_active_power, type='l', xlab="datetime",
                      ylab="Global Active Power"))

#Draw the Voltage Plot
with(FILTERED_DT,plot(DateTime,Voltage, type='l', xlab="datetime"))

#Draw the Energy sub metering Plot  
with(FILTERED_DT,plot(DateTime,Sub_metering_1, type='n', xlab="",
                      ylab="Energy sub metering"))
with(FILTERED_DT,points(DateTime,Sub_metering_1, type="l"))
with(FILTERED_DT,points(DateTime,Sub_metering_2, type="l", col="red"))
with(FILTERED_DT,points(DateTime,Sub_metering_3, type="l", col="blue"))

# Add Legend
# R has four line style arguments: line width (lwd), line end style (lend), 
# line join style (ljoin), and line type(lt). These graphical arguments and  
# their parameters are described within the documentation for the par() 

legend("topright", lty=1,lwd=1, col = c("black", "red","blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

#Draw the Global_reactive_power plot
with(FILTERED_DT,plot(DateTime,Global_reactive_power, type='l',xlab="datetime"))

#close the PNG device
dev.off()
