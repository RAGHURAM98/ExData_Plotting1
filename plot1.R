library(data.table)
DT <- fread("./household_power_consumption.txt",
            sep = ";",
            header = TRUE,
            colClasses = rep("character",9))

DT[DT == "?"] <- NA

# Selecting adequate lines
DT$Date <- as.Date(DT$Date, format = "%d/%m/%Y")
DT <- DT[DT$Date >= as.Date("2007-02-01") & DT$Date <= as.Date("2007-02-02"),]

DT$Global_active_power <- as.numeric(DT$Global_active_power)

# Do the graph
png(file = "plot1.png", width = 480, height = 480, units = "px")
hist(DT$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()
