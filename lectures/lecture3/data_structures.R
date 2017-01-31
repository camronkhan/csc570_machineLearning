# ------------------------
#     Data Structures
# ------------------------

dataStructures <- c("vector", "matrix", "array", "data frame", "list")
dataStructures


# --------------------
#       Vectors
# --------------------

# Default type of data structure is a VECTOR
# Vectors can be thought of as contiguous cells containing data
# c() combines objects into a vector
age <- c(10, 20, 30, 40)
age

# Get single value
age[3]  # NOTE: Index is 1 based (not 0)

# Get slice of a vector
age[2:4]

# Get all excluding second element
age[-2]

# SCALARS are vectors of length 1
temperature <- 32
temperature

# Additional elements can be stored
temperature[2] <- 36.5
temperature  # NOTE: The mode of the vector changed from integer to double since 36.5 is a double
temperature[3] <- "37"
temperature  # NOTE: The mode of the vector changed from double to string since "37" is a string

# Logical vector
logical <- c(TRUE, FALSE, TRUE, FALSE)
logical

# The vector logical contains four logical constants
# A logical vector can be used as a row selector for another vector
age[logical]  # NOTE: Only elements with indexes corresponding to TRUE are selected
  
# COMBINE
# The function c combines its parameters to form a vector
# All parameters are coerced to a common type, which is the highest type of the parameters in the hierarchy:
# NULL < raw < logical < integer < double < complex < character< list < expression
combo <- c(1, "MALE", TRUE)
combo

# The function c can be used to select particular elements from a vector
# The following example creates a vector of six characters and selects the elements with indexes 1, 3, and 5
letters <- c("A","B","C","D","E","F")
letters
letters[c(1,3,5)]
# Exclude elements at indexes 1, 3, and 4
letters[-c(1,3,4)]
# Exclude a range
letters[-(3:4)]
# Include only range
letters[3:4]


# TO BE CONTINUED.....Vector Arithmetic
