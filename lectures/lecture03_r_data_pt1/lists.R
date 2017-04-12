# --------------------
#       Lists
# --------------------


# Unnames
myList <- list("hi", 2)

# Named
myOtherList <- list(first="hi", second=2)
myOtherList

patient <- list("John Doe", 98.1, "MALE")
names(patient) <- c("Name", "Temperature", "Gender")
patient

# List of single component
patient[3]

# Actual component
patient[[3]]
patient$Gender

# Store component name in var
x <- "Temperature"
patient[[x]]

# Abbreviation
patient$Temperature
patient$Temp
patient$T
