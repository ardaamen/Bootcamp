# Title: Introduction to R and data manipulation
# Description: This session will be an introduction to the RStudio environment, basic scripting, and data manipulation using modern, user-friendly packages such as tidyr, dplyr, and stringr. Participants will engage in active learning with instructor-led tutorials for the morning and then the afternoon will involve participants tackling real-world data cleaning exercises.
# Instructor: David Martin
# Date/Time: Wednesday August 9th 9:00 - 3:00pm
# Room: Carter

#Intro to RStudio Environment

# COMMENTING

#Setting a Working Directory/Creating Projects
setwd("https://github.com/dnm5ca/Bootcamp")


#(Soft-wrapping, etc.)

#Installing Packages (install.packages())
  # #tidyverse
install.packages("tidyverse")
  # #tidyr
install.packages("tidyr")
  # #dplyr  
install.packages("dplyr")
  # #readr
install.packages("readr")
  # #stringr
install.packages("stringr")

#Loading Libraries (library())
    #tidyverse
    library(tidyverse)
    #tidyr
    library(tidyr)
    #dplyr  
    library(dplyr)
    #readr
    library(readr)
    #stringr
    library(stringr)

#Working with Vectors
  
  #Basics (The <- operator, creating vectors, +/-, etc.)
    # Vectors: any value (number/character/etc.); create a vector object to store a given value; values have to be of the same type; character vectors called strings

new_vec <- 5
new_vec2 <- 3 + new_vec
new_vec3 <- c(5, 1, 6, 1)
#c() to concatenate
new_vec4 <- "This sentence is..."

  #Built-in Functions
    
#paste function: adds together strings
paste0(new_vec4, "now finished")
#mean function: average of values
mean_var <- mean(c(3, 6, 9, 12))
new_mean_vec <- c(3, 6, 9, 12)
mean_var2 <- mean(new_mean_vec)
sd_var <- sd(c(3, 6, 9, 12))

#Working with the Environment
  #ls() - list all objects in the environment
ls()  

  #rm() - remove one object at a time
rm(mean_var)
    
  #rm(list = ls()) - remove all objects in the environment
rm(list = ls())  
  
    #INTRO EXERCISE 1 - Creating Objects.
    
    # 1.	You have a patient with a height (inches) of 73 and a weight (lbs) of 203. Create r objects labeled 'height' and 'weight'.
 
height_inches <- 73
weight_lbs <- 203
   
    # 2.	Convert 'weight' to 'weight_kg' by dividing by 2.2. Convert 'height' to 'height_m' by dividing by 39.37
    
weight_kg <- weight_lbs / 2.2
height_m <- height_inches / 39.37

    # 3.	Calculate a new object 'bmi' where BMI = weight_kg / (height_m*height_m)
    
bmi <- weight_kg / (height_m*height_m)

    #----------------------------------------------------------#
    
#DATAFRAMES
#Talk about dataframes. 
  #What is a dataframe? data table/data set; like an excel spreadsheet; a collection of vectors or objects; can be mixed types 
  
  #What does it look like? like a typical excel file

    # All about Tidy Data
      # Each variable in its own column
      # Each Observation in its own row

  
#Getting data into a dataframe/tibble: tibble gives more information but nearly interchangeable
  #Reading in Data
    #read.csv() vs. read_csv(): similar outputs for both functions but easier to view read_csv output
    
nhanes <- read_csv("nhanes_long.csv") #saving into a dataframe object


  #Writing out Data
    #write.csv() or write_csv()
write_csv(nhanes, "nhanes_copy.csv")

#Summarizing a Dataframe
  #Taking a peek at the dataframe - View, head, tail
    #View: can look at data in new window; just running the table variable gives a quick glance of data in console and info on dataframe
    #head: function to look at top of data set (include argument with , # to specify number of rows to show
    #tail: same as head but for end of data set
View(nhanes)
head(nhanes, 20)
tail(nhanes, 20)

  #Describing the structure of the dataframe - nrow, ncol, dim
    #dim: function to provide dimensions/structure of data frame; nrow and ncol to give rows/columns
dim(nhanes)
nrow(nhanes)
ncol(nhanes)

  #Ways to describe the data - summary, etc.; detailed info on data frame
  #str: function that provides structure of object; $ indicates variables of dataframe

summary(nhanes)
str(nhanes)

#Accessing elements of a dataframe 
  #By Name
nhanes$Gender
  #Creating a vector from elements of a dataframe 
income_vec <- nhanes$Income

  #By Position (default column)
nhanes[3] #looking at 3rd column 
nhanes_temp <- nhanes[c(2, 4, 5)]

  #Subsetting a dataframe - by row
nhanes[3, ]

  #Subsetting a dataframe - by cell
nhanes[3, 5]
many_cells <- nhanes[3, 1:8] #taking a range of cells row3, cols 1-8
many_cells2 <- nhanes[1, "Gender"]
combo <- nhanes[1:5, 3:8]
combo

#Using functions within a dataframe
  #mean, sd, etc.
sd(nhanes$Testosterone, na.rm = TRUE) #na.rm: argument to say don't look at missing values
mean(nhanes$visit_num, na.rm = TRUE)

  #cor, sum, rank, paste
    #Using Built-in Help (?)
?cor  #help page for correlation function
cor(nhanes$BPDia, nhanes$BPSys, use = "pairwise")
?rank #rank: ranks thinsg by value
nhanes$newvar <- rank(nhanes$Testosterone) #add a new column to dataframe; could also use this to replace a column name
paste(nhanes$Race, nhanes$Education)
paste0(nhanes$Race, nhanes$Education)    

    #paste adds space between strings, paste0 does not  

    #INTRO EXERCISE 2 - Functions.
    # 1. See ?abs and ?sqrt. Calculate the square root of the absolute value of -4*(2550-50).
?abs
?sqrt
abs_value <- abs(-4*(2550-50))
sqrt_abs <- sqrt(abs)

    # 2.	What's the range of ages represented in the NHANES data? (hint: range()).
?range
range(nhanes$Age)

    # 3.	Within the NHANES dataset, how many distinct values are there in the Gender variable and the Education variable (hint: ?n_distinct())
?n_distinct
n_distinct(nhanes$Gender)
n_distinct(nhanes$Education)
n_distinct(nhanes$Education, na.rm = TRUE)

    #----------------------------------------------------------#
    
#Conditionals
    # - `==`: Equal to, `!=`: Not equal to
    # - `>`, `>=`: Greater than, greater than or equal to
    # - `<`, `<=`: Less than, less than or equal to
    # - | : Or, & : And
    
  #if something is true, then do something 
    #ifelse: (condition, value if condition is true, value if condition is false)

nhanes$High_BPDia <- ifelse(nhanes$BPDia >= 85, "Yes", "No")
nhanes$High_BPDia
nhanes$PA <- ifelse(nhanes$PhysActive == "Yes", 1, 0)
sum(nhanes$PA == 1, na.rm = TRUE)

gender_male_count <- sum(nhanes$Gender == "male", na.rm = TRUE)

nhanes$High_BPDia_PA <- ifelse(nhanes$BPDia > 85 & nhanes$PhysActive == "Yes", 1, 0)
  #To inclue multiple categories use nested ifelse statements
nhanes$High_BPDia_PA <- ifelse(nhanes$BPDia > 85 & nhanes$PhysActive == "Yes", 1, ifelse(nhanes$BPDia >= 85 & nhanes$PhysActive == "No", 2, 3))

    #INTRO EXERCISE 3 - Conditionals.
    #1. Create a variable, nhanes_manyRooms, that is equal to "Yes" if there are more than 7 rooms in their house (see the HomeRooms variable). How many patients fall into this category?
    
nhanes_manyRooms <- ifelse(nhanes$HomeRooms > 7, "Yes", "No")
sum(nhanes_manyRooms == "Yes", na.rm = TRUE)

    #2. Create an indicator variable, nhanes_InsuredHomeOwn, that is equal to 1 if the patient is Insured and Owns a Home and 0 otherwise (See the Insured and HomeOwn variables). How many patients fall into this nhanes_InsuredHomeOwn category? 

nhanes_InsuredHomeOwn <- ifelse(nhanes$Insured == "Yes" & nhanes$HomeOwn == "Own", 1, 0)
sum(nhanes_InsuredHomeOwn == 1, na.rm = TRUE)

      #---------------------------------------------------------------#
      
# The Pipe Operator - Allows for the chaining of commands in R
    #Explain and use the pipe operator (Pipe == Then); Operator: %>%

nrow(nhanes)
nhanes %>% #don't have to keep typing nhanes for each variable in the following operations
  nrow()

nhanes_Height <- nhanes$Height %>%
  sd(na.rm = TRUE) #same as getting sd of Height column of nhanes dataframe
nhanes_Height

#DPLYR
  #The DPLYR Package offers a series of built-in functions allowing the user to use easy to understand function names to manipulate their data.
    #Uses verbs that are more intuitive to their function
  
  # filter - Selects the rows you want to look at based off of certain criteria.
    #alternative to nesting ifelse statements
filter(nhanes, BPDia > 85)
filter(nhanes, Gender == "male" & BPDia > 85)

  # Using the pipe with filter
nhanes %>%  #shortcut for pipe: ctl+shift+m
  filter(BPDia > 85)

nhanes_HighBP_male <- nhanes %>% 
  filter(BPDia >= 85) %>% #can't put 2 commands in the same pipe; need to include pipe for each
  filter(Gender == "male")
nhanes_HighBP_male

  # select - Selects the columns you want to look at.
select(nhanes, BPDia, BPSys)
nhanes %>% 
  select(BPDia, BPSys)
new_df <- nhanes %>% 
  select (-id) %>% #new dataframe with everything but the id column
  View()

select(nhanes, -c(3:35))

  # Combining Filter and Select: really helps narrow scope of data you are looking at
nhanes %>% 
  filter(SmokingStatus == "Current") %>% 
  select(id, Age, SmokingStatus) %>% 
  View()

#### DPLYR EXERCISE 1 #####
    # 1. Using filter and select, display the Age, Gender, MaritalStatus, Work, HDLChol, and TotChol data where the patient is "NotWorking" and has never been married. (Answer should return a 224-by-6 tibble/dataframe).

nhanes %>% 
  filter(Work == "NotWorking") %>% 
  filter(MaritalStatus == "NeverMarried") %>% 
  select(Age, Gender, MaritalStatus, Work, HDLChol, TotChol)

    # 2. Display the patient data where the Pulse is really high (in the top 1% of all patients). _Hint:_ see `?quantile` and try `quantile(nhanes$Pulse, probs=.99, na.rm = TRUE) to see the pulse value which is higher than 99% of all the data, then `filter()` based on that. Use Select to look at the Age, Gender, and BMI for these patients. Answer should return a 56-by-3 tibble/data frame.

?quantile

Pulse_quant <- quantile(nhanes$Pulse, probs = .99, na.rm = TRUE)
Pulse_quant
nhanes %>% 
  filter(Pulse >= Pulse_quant) %>% 
  select(Age, Gender, BMI)

    #----------------------------------------------------------#
    
  # mutate - changes or creates a new variable/column
View(mutate(nhanes, Testosterone_Squared = Testosterone ^ 2))

    # mutate using a function
View(mutate(nhanes, Testosterone_mean = mean(Testosterone, na.rm = TRUE)))

    # mutate using a conditional
nhanes <- mutate(nhanes, High_BPDia = ifelse(BPDia > 85, "High", "Low"))
  
    # mutate with the pipe  
  
nhanes_new <- nhanes %>% 
  mutate(High_BPDia = ifelse(BPDia > 85, "High", "Low"))

nhanes_new <- nhanes %>% 
  mutate_if(is.numeric, replace_na, 0) #mutate command with condition as first argument

View(nhanes_new)

nhanes_new <- nhanes %>% 
  mutate_if(is.character, replace_na, "")


    #### DPLYR EXERCISE 2 #####
    
    # 1. Using Mutate, create an indicator (LowSleep) for those patients that get 6 or less hours of sleep a night (SleepHrsNight).
nhanes <- nhanes %>% 
  mutate(LowSleep = ifelse(SleepHrsNight <= 6, 1, 0))
View(nhanes)

    # 2. Filter using the LowSleep indicator and Select the Age, SleepHrsNight, BPSys, and BPDia variables
nhanes %>% 
  filter(LowSleep == 1) %>% 
  select(Age, SleepHrsNight, BPSys, BPDia)

    # 3. Using mutate, create a "Low", "Medium", and "High" indicator (HDLChol_cat) for the TotChol variable ranging from 0 to 3, 3 to 5.5, and 5.5 and above. Use select and View() to show Age, Gender, TotChol and TotChol_cat.
nhanes %>% 
  mutate(TotChol_cat = ifelse(TotChol >= 0 & TotChol < 3, "Low", ifelse(TotChol >= 3 & TotChol < 5.5, "Medium", "High"))) %>% 
  select(Age, Gender, TotChol, TotChol_cat) %>% 
  View()
    
    
  #----------------------------------------------------------#
    
  # summarize - Applies a function to a group 
  # group_by - Tells a function which group(s) to act upon
  # Look at cheatsheet (Help -> Cheatsheets -> Data Manipulation with DPLYR, TidyR) for small list of functions you can use in R
summary(nhanes$Testosterone)
summarize(nhanes, mean(Testosterone, na.rm = TRUE))

    #Can use Group by to group by one variable
summarize(group_by(nhanes, Gender), mean(Testosterone, na.rm = TRUE))

    #Advantage of using the Pipe 
nhanes %>% 
  group_by(Education) %>% 
  summarize(n()) #to give the number of people under each Education input

    #Group by multiple variables
nhanes %>% 
  group_by(Gender, Education) %>% 
  summarize(n())

    #Old Way

    #Pipe Way
nhanes %>%
  group_by(Gender, Race) %>% 
  summarize(mean_size = mean(Age, na.rm = TRUE), min_HDLChol = min(HDLChol)) %>% 
  filter(!is.na(min_HDLChol)) %>% 
  select(Gender, mean_size, min_HDLChol)

    #### DPLYR EXERCISE 3 #####
    
    #1. When the poverty level is less than 2, what is the average weight across all patients that are Single, separately for each Smoking Status? _Hint:_ 3 pipes: `filter`, `group_by, `summarize.

nhanes %>% 
  filter(Poverty < 2 & RelationshipStatus == "Single") %>%
  group_by(SmokingStatus) %>% 
  summarize(mean(Weight, na.rm = TRUE))

    #----------------------------------------------------------#

#Manipulating Strings: helpful for quickly cleaning up data
  #Paste/Paste0 Redux
paste("We Need", "a little space")
paste0("I'd rather stick", "close by!")

  #Detect Matches
    #str_detect - detects the presence of a pattern match in a string; readout is True/False
str_detect("This is something", "is") #looking for "is" in phrase "This is something"
str_detect("This is not something", "Am I Here?")

    #Use of Regular Expressions: See the stringr cheat sheet for reference
      # Overview of Regular Expressions
str_detect("Is there a number here?", "[:digit:]")
str_detect("Is there a 343 number here?", "[:digit:]")
str_detect("Is this a question?", "[\\?]")

  #Detect whether someone received less than high school (8th -> 9th-11th)  
str_detect(nhanes$Education, "th")
nhanes_noHS <- nhanes %>% 
  mutate(HS_Category = ifelse(str_detect(Education, "th"), "Less than HS", "HS or More")) %>% 
  filter(HS_Category == "Less than HS" & !is.na(TotChol)) %>% 
  group_by(Gender) %>% 
  summarize(meanexp=mean(TotChol))

    #str_which - Find the indexes of strings that contain a pattern match.
str_which(nhanes$Educaiton, "th") #gives the row of where detections were made

    #str_count - Count the number of matches in a string.
str_count(nhanes$Education, "h")

    #str_locate - Shows the location of the pattern matches in a string; which character in string the pattern was found in
str_locate(nhanes$Education, "th")

  #Subset strings
    #str_sub - Extract substrings from a character vector.
str_sub("Here is a substring, let us look at it", 11, 19) #(string to look at, range of characters in string to pull out (start, stop))

      # You can also assign character vectors to a substring
n_distinct(nhanes$Gender) #number of values for Gender
str_sub(nhanes$Gender, 7, 8) <- ""  #removes extra characters, in particular from the word female in the gender column of dataframe
n_distinct(nhanes$Gender)

    #str_subset - Return only the strings that contain a pattern match.
str_subset("Here is a substring, let us look at it", "substring")
str_subset(nhanes$Race, "a")


      #### String Exercise 1 #####
      #1. Create the string vector "This is a test string for us to look at in this exercise, tell me what you can find."  
         # Using str_detect, check whether the following strings or patterns are found.
         #  a. "ell"
         #  b. "Exe"
         #  c. "!"
         #  d. "[:digit:]"

test_string <- "This is a test string for us to look at in this exercise, tell me what you can find"
test_string
str_detect(test_string, "ell")
str_detect(test_string, "Exe")
str_detect(test_string, "!")
str_detect(test_string, "[:digit:]")

      #2. Create a substring within the nhanes dataset for RelationshipStatus that starts at the first character and is 4 characters long.

str_sub(nhanes$RelationshipStatus, 1, 4)

      #3. Filter the nhanes dataset by patients that have an "a" or "A" in the Race variable. Select the Age and Race columns.

nhanes %>% 
  str_subset(Race, "a") %>% 
  str_subset(Race, "A") %>% 
  group_by(Age, Race)

      #--------------------------#
      
  #Manage Lengths
    #str_length - Find the length of a string
str_length("How long is this string")
str_length(nhanes$Education)

    #str_trim - Trims away white spaces from the beginning and end of a string
str_trim("   THIS has  TOOO  Much  S  Space")

    #str_squish - Trims extra white space from the beginning, middle, and end of a sentence
str_squish("   THIS has  TOOO  Much  S  Space")

   #Mutate Strings
    #str_replace() - Replace the first matched pattern in each string.
str_replace("This is something", "is", "bacon")

    #str_replace_all() - Replace all matched patterns in each string.
str_replace_all("This is something", "is", "bacon")
n_distinct(nhanes$Gender)
nhanes$Gender <- nhanes$Gender %>% 
  str_replace("r", "")
n_distinct(nhanes$Gender)

    #str_to_lower() - set all characters in string to lowercase
nhanes$Gender <- nhanes$Gender %>% 
  str_to_lower()

    #str_to_upper() - set all characters in string to uppercase
str_to_upper("raise your voice")

    #str_to_title() - - set the first character in string to uppercase
str_to_title("this is my book title")

      #Compare the 3 modifiers
 
      #--------------------------#
#Merging/Appending/Reshaping Data
    # rbind, cbind

   
    # Bind Columns
    
    # Bind Rows
    
    #Full Join

    # Gather/Spread
    
    #Save Final CSV.
    
    