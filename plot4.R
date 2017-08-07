library(data.table)
DT <- fread("./household_power_consumption.txt",
            sep = ";",
            header = TRUE,
            colClasses = rep("character",9))

# Convert "?" in NAs
DT[DT == "?"] <- NA

# Selecting adequate lines
DT$Date <- as.Date(DT$Date, format = "%d/%m/%Y")
DT <- DT[DT$Date >= as.Date("2007-02-01") & DT$Date <= as.Date("2007-02-02"),]

# Joining day and time to create a new posix date
DT$posix <- as.POSIXct(strptime(paste(DT$Date, DT$Time, sep = " "),
                                format = "%Y-%m-%d %H:%M:%S"))

# Convert column that we will use to correct class
DT$Global_active_power <- as.numeric(DT$Global_active_power)

# Do the graph
png(file = "plot4.png", width = 480, height = 480, units = "px")

## Setting 4 graphs
par(mfrow = c(2, 2))

## Graph 1
with(DT,
     plot(posix,
          Global_active_power,
          type = "l",
          xlab = "",
          ylab = "Global Active Power"))

## Graph 2
with(DT,
     plot(posix,
          Voltage,
          type = "l",
          xlab = "datetime",
          ylab = "Voltage"))

## Graph 3
with(DT,
     plot(posix,
          Sub_metering_1,
          type = "l",
          xlab = "",
          ylab = "Energy sub metering"))
with(DT,
     points(posix,
            type = "l",
            Sub_metering_2,
            col = "red")
)
with(DT,
     points(posix,
            type = "l",
            Sub_metering_3,
            col = "blue")
)
legend("topright", col = c("black", "blue", "red"),
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty = 1)

## Graph 4
with(DT,
     plot(posix,
          Global_reactive_power,
          type = "l",
          xlab = "datetime",
          ylab = "Global_reactive_power"))
dev.off() # Close the png file device

