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

  # PLOT
## Creating a histogram of Global Active Power
hist(
  data$Global_active_power,
  main = "Global Active Power",
  col = "red",
  xlab = "Global Active Power (kilowatts)"
)

  # COPY
## Copying the plot to png file
dev.copy(png, file="plot1.png")
dev.off()