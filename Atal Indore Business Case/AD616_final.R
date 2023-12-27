library(tidyverse)
non_peak <- read.csv2('non-peak hours1.csv') #non peak 11:30 A.M. TO 14:30 P.M
peak <- read.csv2('peak-hours1.csv') # number of passangers traveling  7:30 A.M. TO 11:30 A.M. 


# non peak data 
non_peak <- non_peak[-1, ] #remove first row 
non_peak <- non_peak[-1, ] # remove distance 
non_peak <- non_peak[-1]
non_peak <- subset(non_peak, select = -X.2)
non_peak <- subset(non_peak, select = -1)
non_peak <- subset(non_peak, select = -1) # remove first collumn
non_peak <- head(non_peak, -1) 

#make chr numeric 
for (col in names(non_peak)[-1]) {
  non_peak[[col]] <- as.numeric(non_peak[[col]])
}


#peak data 
peak <- peak[-1, ]
peak <- peak[-1, ]
peak <- subset(peak, select = -X.2)
peak <- subset(peak, select = -1)
peak <- subset(peak, select = -1)
peak <- subset(peak, select = -1)
peak <- head(peak, -1) 
peak <- head(peak, -1) 
peak <- head(peak, -1) 
#make chr numeric
for (col in names(peak)[-1]) {  
  peak[[col]] <- as.numeric(peak[[col]])
}

#---------------------- Matrix split data  ----------------------------

#-----------------PEAK HOURS---ROUTE--- Rajiv Ghandi------to----Niranjanpur Sqr------------

# new data is upper triangle 
df <- as.matrix(peak)
mymatrix <- df[, -c(1)]
class(mymatrix)

lower.tri(mymatrix)
mymatrix[lower.tri(mymatrix)] <- NA
mymatrix

# data for route from Rajiv Ghandi to Niranjanpur Sqr
upper_triangle_peak <- as.data.frame(mymatrix)

# clean upper triangle from NA 
upper_triangle_peak[is.na(upper_triangle_peak)] <-0 
upper_triangle_peak[] <- lapply(upper_triangle_peak, as.numeric)

demand_peak <- rowSums(upper_triangle_peak, na.rm=TRUE)
demand_peak # number of passengers per route  

out_1 <- colSums(upper_triangle_peak, na.rm=TRUE)
out_1 # number of passengers out in stop

#-------- determine number of buses by headway----------
demand <- as.data.frame(demand_peak)
out1 <- as.data.frame(out_1) # 
out1 <- rbind(data.frame(out_1 = 0), out1) # add first row to normolize num of collumns 
demand$out_passangers <- out1$out_1 # add 2 collumns

#adding new collum for total occupied seats 
demand$total_occupied_seat <- 0 
demand[1, "total_occupied_seat"] <- 701 # replacing first row by value of demand from summ of first row 

# loop to calculate total occupied seat
  for (i in 1:(nrow(demand-1))){
    demand[i+1, "total_occupied_seat"] <- demand[i, "total_occupied_seat"] + 
      demand[i+1, "demand_peak"]- demand[i+1, "out_passangers"]
  }  

# replace NA to 0
demand[is.na(demand)] <-0 

#DETERMINE DEMAND PER HOUR - 
demand$demand_per_hour <- demand$total_occupied_seat/4 
#DETERMINE NUMBER OF BUS REQUIRED 
Bus_capasity <- 36+15 # value from the case 
demand$Bus_required <- demand$demand_per_hour/Bus_capasity
# DETERMINE APPROPORIATE HEADWAY 
demand$approporiate_headway <- 60/demand$Bus_required

# VALUES FOR ROUTE Rajiv Ghandi to Niranjanpur Sqr
Demand_peak_1 <- demand


#--------------PEAK HOURS---ROUTE----Niranjanpur Sqr------to---Rajiv Ghandi------

df <- as.matrix(peak)
mymatrix1 <- df 
upper.tri(mymatrix1)
mymatrix1[upper.tri(mymatrix1)] <- NA
mymatrix1

# data for route from Rajiv Ghandi to Niranjanpur Sqr
lower_triangle_peak <- as.data.frame(mymatrix1)

# clean upper triangle from NA 
lower_triangle_peak[is.na(lower_triangle_peak)] <-0 
lower_triangle_peak[] <- lapply(lower_triangle_peak, as.numeric)

demand_peak_2 <- rowSums(lower_triangle_peak, na.rm=TRUE)
demand_peak_2 # number of passengers per route  

out_2 <- colSums(lower_triangle_peak, na.rm=TRUE)
out_2 # number of passengers out in stop

#-------- determine number of buses by headway----------
demand2 <- as.data.frame(demand_peak_2)
demand2 <- as.data.frame(demand2)
demand2 <- demand2[nrow(demand2):1, ] # swop row from first to last 

out2 <- as.data.frame(out_2) 
out2 <- out2[nrow(out2):1, ] # swop row from first to last 
#out2 <- as.data.frame(out2)

out2 <- as.data.frame(out2)
demand2$out_passangers <- out2[[1]] # add column using double square brackets

#demand2$out_passangers <- out2$out2 # add 2 collumns

#adding new collum for total occupied seats 
demand2$total_occupied_seat <- 0 
# demand2[1, "total_occupied_seat"] <- 629  # replacing first row by value of demand from summ of first row 
demand2 <- as.data.frame(demand2)
demand2[1, "total_occupied_seat"] <- 629  # replacing first row by value of demand from the summ of the first row


# loop to calculate total occupied seat
#for (i in 1:(nrow(demand2-1))){
#  demand2[i+1, "total_occupied_seat"] <- demand2[i, "total_occupied_seat"] + 
#    demand2[i+1, "demand2"]- demand2[i+1, "out_passangers"]
#}

# Convert demand2 into a data frame
demand2 <- data.frame(demand2)

# Rename the first column to "demand2"
colnames(demand2)[1] <- "demand2"

# loop to calculate total occupied seat
for (i in 1:(nrow(demand2) - 1)){
  demand2[i+1, "total_occupied_seat"] <- demand2[i, "total_occupied_seat"] +
    demand2[i+1, "demand2"] - demand2[i+1, "out_passangers"]
}



# replace NA to 0
demand2[is.na(demand2)] <-0 

#DETERMINE DEMAND PER HOUR - 
demand2$demand_per_hour <- demand2$total_occupied_seat/4 
#DETERMINE NUMBER OF BUS REQUIRED 
Bus_capasity <- 36+15 # value from the case 
demand2$Bus_required <- demand2$demand_per_hour/Bus_capasity
# DETERMINE APPROPORIATE HEADWAY 
demand2$approporiate_headway <- 60/demand2$Bus_required

# VALUES FOR ROUTE Rajiv Ghandi to Niranjanpur Sqr
Demand_peak_2 <- demand2


# SAVE DATA FROM CLACULATION 
write.csv(Demand_peak_2, file = "peak_second.csv", row.names = FALSE)
write.csv(Demand_peak_1, file = "peak_first.csv", row.names = FALSE)

#-----------NON---PEAK HOURS---ROUTE-------------Rajiv Ghandi----to----Niranjanpur Sqr--------------

# upper triangle  -- non peak data 
df_non <- as.matrix(non_peak)
mymatrix_non <- df_non[, -c(1)]
class(mymatrix_non)

lower.tri(mymatrix_non)
mymatrix_non[lower.tri(mymatrix_non)] <- NA

new_non <- as.data.frame(mymatrix_non)

new_non[is.na(new_non)] <-0 
new_non[] <- lapply(new_non, as.numeric)

first_rowwise_non <- rowSums(new_non,na.rm=TRUE)
first_rowwise_non # sum of each row 

first_collumnwise_non <- colSums(new_non, na.rm=TRUE)
first_collumnwise_non # sum of each row 

#-------- determine number of buses by headway----------
demand_non <- as.data.frame(first_rowwise_non)
demand_non  <- demand_non [-21, ]
demand_non <- as.data.frame(demand_non)

out_non <- as.data.frame(first_collumnwise_non) 
out_non <- as.data.frame(out_non)

demand_non$out_passangers <- out_non$first_collumnwise_non  # add 2 collumns

#adding new collum for total occupied seats 
demand_non$total_occupied_seat <- 0 
demand_non[1, "total_occupied_seat"] <- 119  # replacing first row by value of demand from summ of first row 

# loop to calculate total occupied seat
for (i in 1:(nrow(demand_non-1))){
  demand_non[i+1, "total_occupied_seat"] <- demand_non[i, "total_occupied_seat"] + 
    demand_non[i+1, "demand_non"]- demand_non[i+1, "out_passangers"]
}  

# replace NA to 0
demand_non[is.na(demand_non)] <-0 

#DETERMINE DEMAND PER HOUR - 
demand_non$demand_per_hour <- demand_non$total_occupied_seat/4 
#DETERMINE NUMBER OF BUS REQUIRED 
Bus_capasity <- 36+15 # value from the case 
demand_non$Bus_required <- demand_non$demand_per_hour/Bus_capasity
# DETERMINE APPROPORIATE HEADWAY 
demand_non$approporiate_headway <- 60/demand_non$Bus_required



# ----- lower triangle ---------

df_non <- as.matrix(non_peak)
mymatrix_non1 <- df_non #[, -c(1)]
class(mymatrix_non1)

upper.tri(mymatrix_non1)
mymatrix_non1[upper.tri(mymatrix_non1)] <- NA

new_non1 <- as.data.frame(mymatrix_non1)

new_non1[is.na(new_non1)] <-0 
new_non1[] <- lapply(new_non1, as.numeric)

first_rowwise_non1 <- rowSums(new_non1,na.rm=TRUE)
first_rowwise_non1 # sum of each row 

first_collumnwise_non1 <- colSums(new_non1, na.rm=TRUE)
first_collumnwise_non1 # sum of each row 

#-------- determine number of buses by headway----------
demand_non1 <- as.data.frame(first_rowwise_non1)
demand_non1 <- as.data.frame(demand_non1)
demand_non1 <- demand_non1[nrow(demand_non1):1,] # swop row from first to last 
demand_non1 <- as.data.frame(demand_non1)

out_non1 <- as.data.frame(first_collumnwise_non1) 
out_non1 <- out_non1[nrow(out_non1):1, ] # swop row from first to last 
out_non1 <- as.data.frame(out_non1)

demand_non1$out_passangers <- out_non1$out_non1  # add 2 collumns

#adding new collum for total occupied seats 
demand_non1$total_occupied_seat <- 0 
demand_non1[1, "total_occupied_seat"] <- 139  # replacing first row by value of demand from summ of first row 

# loop to calculate total occupied seat
for (i in 1:(nrow(demand_non1-1))){
  demand_non1[i+1, "total_occupied_seat"] <- demand_non1[i, "total_occupied_seat"] + 
    demand_non1[i+1, "demand_non1"]- demand_non1[i+1, "out_passangers"]
}  

# replace NA to 0
demand_non1[is.na(demand_non1)] <-0 

#DETERMINE DEMAND PER HOUR - 
demand_non1$demand_per_hour <- demand_non1$total_occupied_seat/4 
#DETERMINE NUMBER OF BUS REQUIRED 
Bus_capasity <- 36+15 # value from the case 
demand_non1$Bus_required <- demand_non1$demand_per_hour/Bus_capasity
# DETERMINE APPROPORIATE HEADWAY 
demand_non1$approporiate_headway <- 60/demand_non1$Bus_required

# SAVE DATA FROM CLACULATION of NON PEAK DATA 
write.csv(demand_non1, file = "nonpeak_second.csv", row.names = FALSE)
write.csv(demand_non, file = "nonpeak_first.csv", row.names = FALSE)

### Part 5 Determine bus scheduling and deployment plans on both routes given the desired frequency.

# Read the saved peak and non-peak hour data
peak_first <- read.csv("peak_first.csv")
peak_second <- read.csv("peak_second.csv")
nonpeak_first <- read.csv("nonpeak_first.csv")
nonpeak_second <- read.csv("nonpeak_second.csv")

# Desired frequency (in minutes)
desired_frequency_peak <- 10
desired_frequency_nonpeak <- 20

# Function to calculate the number of buses and schedule based on desired frequency
calculate_schedule <- function(data, desired_frequency) {
  data$desired_headway <- desired_frequency
  data$desired_buses <- ceiling(data$demand_per_hour / (60 / desired_frequency))
  data$schedule <- lapply(data$desired_buses, function(x) seq(0, 60 - desired_frequency, by = desired_frequency)[1:x])
  return(data)
}

# Calculate bus schedules and deployment plans for peak hours
peak_first_schedule <- calculate_schedule(peak_first, desired_frequency_peak)
peak_second_schedule <- calculate_schedule(peak_second, desired_frequency_peak)

# Calculate bus schedules and deployment plans for non-peak hours
nonpeak_first_schedule <- calculate_schedule(nonpeak_first, desired_frequency_nonpeak)
nonpeak_second_schedule <- calculate_schedule(nonpeak_second, desired_frequency_nonpeak)

# Convert the schedule lists to strings
peak_first_schedule$schedule <- sapply(peak_first_schedule$schedule, paste, collapse = ",")
peak_second_schedule$schedule <- sapply(peak_second_schedule$schedule, paste, collapse = ",")
nonpeak_first_schedule$schedule <- sapply(nonpeak_first_schedule$schedule, paste, collapse = ",")
nonpeak_second_schedule$schedule <- sapply(nonpeak_second_schedule$schedule, paste, collapse = ",")

# Save the bus schedules and deployment plans
write.csv(peak_first_schedule, file = "peak_first_schedule.csv", row.names = FALSE)
write.csv(peak_second_schedule, file = "peak_second_schedule.csv", row.names = FALSE)
write.csv(nonpeak_first_schedule, file = "nonpeak_first_schedule.csv", row.names = FALSE)
write.csv(nonpeak_second_schedule, file = "nonpeak_second_schedule.csv", row.names = FALSE)


# Read the saved bus schedules and deployment plans
peak_first_schedule <- read.csv("peak_first_schedule.csv")
peak_second_schedule <- read.csv("peak_second_schedule.csv")
nonpeak_first_schedule <- read.csv("nonpeak_first_schedule.csv")
nonpeak_second_schedule <- read.csv("nonpeak_second_schedule.csv")

# Desired frequency (in minutes)
desired_frequency_route_a <- 15
desired_frequency_route_b <- 30

# Function to calculate the number of buses and schedule based on desired frequency
calculate_schedule <- function(data, desired_frequency) {
  data$desired_headway <- desired_frequency
  data$desired_buses <- ceiling(data$demand_per_hour / (60 / desired_frequency))
  data$schedule <- lapply(data$desired_buses, function(x) seq(0, 60 - desired_frequency, by = desired_frequency)[1:x])
  return(data)
}

# Calculate bus schedules and deployment plans for Route A
route_a_schedule <- calculate_schedule(peak_first_schedule, desired_frequency_route_a)

# Calculate bus schedules and deployment plans for Route B
route_b_schedule <- calculate_schedule(nonpeak_second_schedule, desired_frequency_route_b)

# Convert the schedule lists to strings
route_a_schedule$schedule <- sapply(route_a_schedule$schedule, paste, collapse = ",")
route_b_schedule$schedule <- sapply(route_b_schedule$schedule, paste, collapse = ",")

# Print the bus schedules and deployment plans
print(paste0("Route A:\n", "Deploy ", nrow(route_a_schedule), " buses with a gap of ", desired_frequency_route_a, " minutes:\n"))
cat(paste0("Bus ", 1:nrow(route_a_schedule), ": ", route_a_schedule$schedule, "\n"))

print(paste0("\nRoute B:\n", "Deploy ", nrow(route_b_schedule), " buses with a gap of ", desired_frequency_route_b, " minutes:\n"))
cat(paste0("Bus ", 1:nrow(route_b_schedule), ": ", route_b_schedule$schedule, "\n"))


# Create data frames for the bus schedules
route_a <- data.frame(bus = rep(1:6, each = 4), 
                      time = c(0, 15, 30, 45, 7.5, 22.5, 37.5, 52.5, 15, 30, 45, 7.5, 22.5, 37.5, 52.5, 0, 15, 30, 45, 15, 30, 45, 0, 0))
route_b <- data.frame(bus = rep(1:3, each = 2), time = c(0, 30, 15, 45, 0, 30))

library(ggplot2)
# Plot the bus schedules
ggplot() +
  # Add vertical lines for each time point
  geom_vline(xintercept = seq(0, 60, by = 15), color = "gray70") +
  # Add points for each bus departure
  geom_point(data = route_a, aes(x = time, y = bus, color = "Route A"), size = 4) +
  geom_point(data = route_b, aes(x = time, y = bus, color = "Route B"), size = 4) +
  # Add text labels for the bus numbers
  geom_text(data = route_a, aes(x = time, y = bus, label = paste0("Bus ", bus)), size = 3, hjust = -0.1, vjust = 0.5) +
  geom_text(data = route_b, aes(x = time, y = bus, label = paste0("Bus ", bus)), size = 3, hjust = -0.1, vjust = 0.5) +
  # Customize the axis labels and legend
  scale_x_continuous(breaks = seq(0, 60, by = 15), limits = c(0, 60), expand = c(0, 0)) +
  scale_y_continuous(limits = c(0.5, 6.5), expand = c(0, 0)) +
  labs(x = "Time (minutes)", y = "Bus Number", color = "Route") +
  theme_bw()


