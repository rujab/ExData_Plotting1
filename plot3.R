  # DATA
## Getting the column names to use them for the reduced data table
names <-
  names(read.table(
    "household_power_consumption.txt",
    nrows = 1,
    header = TRUE,
    sep = ";"
  ))

## Getting the number of rows to skip
## Number of minutes in 2 days is 2880, so it
## is the number of rows we have to read
skip <-
  grep("1/2/2007", readLines("household_power_consumption.txt")) - 1

## Reading the part of data we need
data <-
  read.table(
    "household_power_consumption.txt",
    skip = skip[1],
    nrows = 2880,
    sep = ";",
    col.names = names,
    na.strings = "?"
  )

## Creating a new variable Moment by pasting Date and Time
## and converting to date/time
data$Moment <-
  strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

  # PLOT
## Creating an empty plot and adding lines Sub metering 1, 2
## and 3 - time
plot(
  data$Moment,
  data$Sub_metering_1,
  type = "n",
  xlab = "",
  ylab = "Energy sub metering"
)
points(data$Moment,
       data$Sub_metering_1,
       type = "l",
       col = "black")
points(data$Moment,
       data$Sub_metering_2,
       type = "l",
       col = "red")
points(data$Moment,
       data$Sub_metering_3,
       type = "l",
       col = "blue")
## Adding a legend
legend(
  "topright",
  pch = c("_", "_", "_"),
  col = c("black", "red", "blue"),
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)

  # COPY
## Copying the plot to png file
dev.copy(png, file="plot3.png")
dev.off()