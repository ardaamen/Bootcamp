# Title: Introduction to R and data manipulation
# Description: This session will be an introduction to the RStudio environment, basic scripting, and data manipulation using modern, user-friendly packages such as tidyr, dplyr, and stringr. Participants will engage in active learning with instructor-led tutorials for the morning and then the afternoon will involve participants tackling real-world data cleaning exercises.
# Instructor: David Martin
# Date/Time: Wednesday August 9th 9:00 - 3:00pm
# Room: Carter

#Intro to RStudio Environment

#Setting a Working Directory/Creating Projects

#(Soft-wrapping, etc.)

#Installing Packages (install.packages())
  # #tidyverse
  #  install.packages("tidyverse")
  # #tidyr
  #   install.packages("tidyr")
  # #dplyr  
  #   install.packages("dplyr")
  # #readr
  #   install.packages("readr")
  # #stringr
  #   install.packages("stringr")

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
  
  5+7
  9*15
  
  #Basics (The <- operator, creating vectors, +/-, etc.)
    new_vec <- 2
    new_vec2 <- 3 + new_vec
    new_vec3 <- c(5, 1, 6, 1)  
    new_vec4 <- "This sentence is..."
    
  #Built-in Functions
    paste0(new_vec4, "now finished.")
    mean_var <- mean(c(3, 6, 9, 12))
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
    
    # 2.	Convert 'weight' to 'weight_kg' by dividing by 2.2. Convert 'height' to 'height_m' by dividing by 39.37
    
    # 3.	Calculate a new object 'bmi' where BMI = weight_kg / (height_m*height_m)
    
    #----------------------------------------------------------#
    
#DATAFRAMES
#Talk about dataframes. 
  #What is a dataframe?
  
  #What does it look like? 
  
    # All about Tidy Data
      # Each variable in its own column
      # Each Observation in its own row

  id       <- c(1, 2, 3, 4)
  mean_var <- c(3, 6, 9, 12)
  sd_var   <- c(.7, 1.6, .3, 2.1)
    
  data.frame(id, mean_var, sd_var)
  a_data_frame <- data.frame(id, mean_var, sd_var)
  data.frame(c(1, 2, 3, 4), c(3, 6, 9, 12))
  
  
#Getting data into a dataframe/tibble
  #Reading in Data
    #read.csv() vs. read_csv()
    nhanes <- read_csv("nhanes_long.csv") # Header is defaulted as true.
  #Writing out Data
    #write.csv()
    write_csv(nhanes, "nhanes_copy.csv")
  
#Summarizing a Dataframe
  #Taking a peek at the dataframe - View, head, tail
    View(nhanes)
    head(nhanes)
    tail(nhanes)
    
  #Describing the structure of the dataframe - nrow, ncol, dim
    nrow(nhanes)
    ncol(nhanes)
    dim(nhanes)
    
  #Ways to describe the data - summary, etc.
    summary(nhanes)
    class(nhanes)
    str(nhanes)
    
#Accessing elements of a dataframe 
  #By Name
    nhanes$Gender
    nhanes["Gender"]
    nhanes["Income"]
    income_vec <- nhanes$Income
    income_vec
  
  #By Position
    nhanes[3]
    nhanes[c(2, 4, 5)]
    new_vec <- nhanes[c(1,5,8)]
    new_vec
  
  #Subsetting a dataframe - by row
    nhanes[3, ]
    
    a_row <- nhanes[3, ]
    View(a_row)
  
  #Subsetting a dataframe - by cell
    nhanes[3, 1]
    a_cell <- nhanes[3, 12]
    a_cell
    many_cells <- nhanes[3, 1:8]
    many_cells
    combo <- nhanes[1:5, 1:8]
    combo
    
#Using functions within a dataframe
  #mean, sd, etc.
    sd(nhanes$Testosterone)
    mean(nhanes$BPDia)
    mean(nhanes[, 2])
    
  #cor, sum, rank, paste
    #Using Built-in Help (?)
    ?cor
    cor(nhanes$BPDia, nhanes$BPSys, use = "pairwise")
    nhanes$new_sum <- sum(nhanes$Weight, na.rm = TRUE) #Can create new columns from functions
    
    ?rank
    nhanes$new_var <- rank(nhanes$Testosterone)

    #paste adds space between strings, paste0 does not  
    paste(nhanes$Race, nhanes$Education)  
    paste0(nhanes$Race, nhanes$Education)
    
    #INTRO EXERCISE 2 - Functions.
    # 1. See ?abs and ?sqrt. Calculate the square root of the absolute value of -4*(2550-50).
    sqrt(abs(-4 * (2550-50)))
    
    # 2.	What's the range of ages represented in the NHANES data? (hint: range()).
    range(nhanes$Age)
    
    # 3.	Within the NHANES dataset, how many distinct values are there in the Gender variable and the Education variable (hint: ?n_distinct())
    n_distinct(nhanes$Gender)
    n_distinct(nhanes$Education)
    
    #----------------------------------------------------------#
    
#Conditionals
    # - `==`: Equal to, `!=`: Not equal to
    # - `>`, `>=`: Greater than, greater than or equal to
    # - `<`, `<=`: Less than, less than or equal to
    # - | : Or, & : And
    
  #if something is true, then do something 
    nhanes$High_BPDia <- ifelse(nhanes$BPDia >= 85, "Yes", "No")
      sum(nhanes$High_BPDia == "Yes", na.rm = TRUE)
    
    nhanes$PA <- ifelse(nhanes$PhysActive == "Yes", 1, 0)
      sum(nhanes$PA == 1, na.rm = TRUE)
    
    nhanes$High_BPDia_PA <- ifelse(nhanes$BPDia >= 85 & nhanes$PhysActive == "No", 1, ifelse(nhanes$BPDia >= 85 & nhanes$PhysActive == "Yes", 2,3)) 
      sum(nhanes$High_BPDia_PA == 1, na.rm = TRUE)
    
    #INTRO EXERCISE 3 - Conditionals.
    #1. Create a variable, nhanes_manyRooms, that is equal to "Yes" if there are more than 7 rooms in their house (see the HomeRooms variable). How many patients fall into this category?
    nhanes_manyRooms <- ifelse(nhanes$HomeRooms > 7, "Yes", "No")
      sum(nhanes_manyRooms == "Yes", na.rm = TRUE)
    
    #2. Create an indicator variable, nhanes_InsuredHomeOwn, that is equal to 1 if the patient is Insured and Owns a Home and 0 otherwise (See the Insured and HomeOwn variables). How many patients fall into this nhanes_InsuredHomeOwn category? 
    nhanes_InsuredHomeOwn <- ifelse(nhanes$Insured == "Yes" & nhanes$HomeOwn == "Own", 1, 0)
      sum(nhanes_InsuredHomeOwn == 1, na.rm = TRUE)

#---------------------------------------------------------------#
      
# The Pipe Operator - Allows for the chaining of commands in R
    #Explain and use the pipe operator (Pipe == Then)
      nhanes$Weight %>% 
        mean(na.rm = TRUE)
      
      nhanes_Height <- nhanes$Height %>%
        sd(na.rm = TRUE)
      nhanes_Height
      
      nhanes %>% 
        nrow() 
    
#DPLYR
  #The DPLYR Package offers a series of built-in functions allowing the user to use easy to understand function names to manipulate their data.
  
  # filter - Selects the rows you want to look at based off of certain criteria.
    filter(nhanes, BPDia >= 85)
    filter(nhanes, Gender == "male" & BPDia >= 85)
    
  # Using the pipe with filter
    nhanes %>% 
      filter(BPDia >=  85)
    
    nhanes_HighBP_male <- nhanes %>% 
      filter(BPDia >= 85) %>% 
      filter(Gender == "male")
    
    View(nhanes_HighBP_male)
    
  # select - Selects the columns you want to look at.
    select(nhanes, BPDia, BPSys)
    
    new_df <- nhanes %>%
        select(BPDia, BPSys)
    
    new_df
    
    new_df2 <- nhanes %>%
      select(-id)
    new_df2
    
    select(nhanes, -c(3:35))
    select(nhanes, c(1:3, 15:17))
    
    # Combining Filter and Select
    nhanes %>% 
      filter(SmokingStatus == "Current") %>% 
      select(id, Age, SmokingStatus) %>%
      View()
        
#### DPLYR EXERCISE 1 #####
    # 1. Using filter and select, display the Age, Gender, MaritalStatus, Work, HDLChol, and TotChol data where the patient is "NotWorking" and has never been married. (Answer should return a 224-by-6 tibble/dataframe).
      nhanes %>%
        filter(MaritalStatus == "NeverMarried" & Work == "NotWorking") %>%
        select(Age, Gender, MaritalStatus, Work, HDLChol, TotChol)  
      
    # 2. Display the patient data where the Pulse is really high (in the top 1% of all patients). _Hint:_ see `?quantile` and try `quantile(nhanes$Pulse, probs=.99, na.rm = TRUE) to see the pulse value which is higher than 99% of all the data, then `filter()` based on that. Use Select to look at the Age, Gender, and BMI for these patients. Answer should return a 56-by-3 tibble/data frame.
    nhanes %>%
      filter(Pulse >= quantile(Pulse, probs=.99, na.rm = TRUE)) %>%
      select(Age, Gender, BMI)
    #----------------------------------------------------------#
    
  # mutate - changes or creates a new variable/column
    mutate(nhanes, Testosterone_Squared = Testosterone * Testosterone)
    
    # mutate using a function
    mutate(nhanes, Testosterone_mean = mean(Testosterone, na.rm = TRUE))
    
    # mutate using a conditional
    nhanes <- mutate(nhanes, High_BPDia = ifelse(BPDia > 85, "High", "Low"))
    View(nhanes)
    
    # mutate with the pipe
    nhanes_new <- nhanes   %>%  
      mutate(High_BPDia = ifelse(BPDia > 85, "High", "Low"))
      
    nhanes_new <- nhanes  %>% 
      mutate_if(is.numeric, replace_na, 0)
    
    nhanes_new <- nhanes  %>% 
      mutate_if(is.character, replace_na, "") 
    
    nhanes %>%
      mutate(BMI_Category = ifelse(BMI >= 0 & BMI < 15, "Very Low",
                      ifelse(BMI >= 15 & BMI < 25, "Low",
                      ifelse(BMI >= 25 & BMI < 35, "Average",
                      ifelse(BMI >= 35, "High", "")))))
    

    #### DPLYR EXERCISE 2 #####
    
    # 1. Using Mutate, create an indicator (LowSleep) for those patients that get 6 or less hours of sleep a night (SleepHrsNight).
    nhanes <- nhanes %>%
        mutate(LowSleep = ifelse(SleepHrsNight <= 6, 1, 0))
    # 2. Filter using the LowSleep indicator and Select the Age, SleepHrsNight, BPSys, and BPDia variables
    nhanes %>% 
      filter(LowSleep == 1) %>%
      select(Age, SleepHrsNight, BPSys, BPDia)
    
    # 3. Using mutate, create a "Low", "Medium", and "High" indicator (HDLChol_cat) for the TotChol variable ranging from 0 to 3, 3 to 5.5, and 5.5 and above. Use select and View() to show Age, Gender, TotChol and TotChol_cat.
    nhanes %>%
      mutate(TotChol_cat = ifelse(TotChol >= 0 & TotChol < 3, "Low",
                                   ifelse(TotChol >= 3 & TotChol < 5.5, "Medium", "High"))) %>%
      select(Age, Gender, TotChol, TotChol_cat) %>% View()
    
  #----------------------------------------------------------#
    
  # summarize - Applies a function to a group  
  # group_by - Tells a function which group(s) to act upon
  # Look at cheatsheet (Help -> Cheatsheets -> Data Manipulation with DPLYR, TidyR) for small list of functions you can use in R
    summary(nhanes$Testosterone)
    
    summarize(nhanes, mean(Testosterone, na.rm = TRUE))
    summarize(nhanes, IQR(Testosterone, na.rm = TRUE))
    
    summarize(group_by(nhanes, Gender), mean(Testosterone, na.rm = TRUE))
    
    #Can use Group by to group by one variable
    nhanes %>% 
        group_by(Education) %>%
        summarize(n())
    
    #...Or multiple variables
    nhanes %>% 
      group_by(Gender, Race) %>%
      summarize(n())
    
    #Advantage of using the Pipe 
    #Old Way
    select(filter(summarize(group_by(nhanes, Gender, Race), mean_size = mean(Age, na.rm = TRUE), min_HDLChol = min(HDLChol)), !is.na(min_HDLChol)), Gender, mean_size, min_HDLChol)
    
    #Pipe Way
    nhanes %>%
      group_by(Gender, Race) %>%
      summarize(mean_size = mean(Age, na.rm = TRUE), min_HDLChol = min(HDLChol)) %>%
      filter(!is.na(min_HDLChol)) %>%
      select(Gender, mean_size, min_HDLChol)
    
    nhanes %>% 
      filter(Age > 65 & Gender == "female" & !is.na(Insured)) %>% 
      group_by(Insured) %>% 
      summarize(meanexp=mean(Pulse, na.rm = TRUE))
    
    #### DPLYR EXERCISE 3 #####
    
    #1. When the poverty level is less than 2, what is the average weight across all patients that are Single, separately for each Smoking Status? _Hint:_ 3 pipes: `filter`, `group_by, `summarize.
    nhanes %>% 
      filter(Poverty < 2 & RelationshipStatus == "Single") %>%
      group_by(SmokingStatus) %>%
      summarize(mean(Weight, na.rm = TRUE))
    #----------------------------------------------------------#

#Manipulating Strings
  #Paste/Paste0 Redux
    paste("We need", "a little space")
    paste0("I'd rather stick", "close by!")
    paste(nhanes$Education, nhanes$Race)
    
  #Detect Matches
    #str_detect - detects the presence of a pattern match in a string
      str_detect("This is something", "is")
      str_detect("This is not something", "Am I Here?")
      
    #Use of Regular Expressions
      # Overview of Regular Expressions
      str_detect("Is there a number here?", "[:digit:]")
      str_detect("Well are there 3 numbers here?", "[:digit:]")
      str_detect("Is this a question?", "[\\?]")
      str_detect("Is this a question", "[\\?]")
      
  #Detect whether someone received less than high school (8th -> 9th-11th)  
      str_detect(nhanes$Education, "th")
    
      nhanes_NoHS <- nhanes %>%
        mutate(HS_Category = ifelse(str_detect(Education, "th"), "Less than HS", "HS or More"))
      
      nhanes_NoHS <- nhanes %>%
        mutate(HS_Category = ifelse(str_detect(Education, "th"), "Less than HS", "HS or More")) %>% 
        filter(HS_Category == "Less than HS" & !is.na(TotChol))
      
      nhanes_NoHS <- nhanes %>%
        mutate(HS_Category = ifelse(str_detect(Education, "th"), "Less than HS", "HS or More")) %>% 
        filter(HS_Category == "Less than HS" & !is.na(TotChol)) %>% 
        group_by(Gender)
      
      nhanes_NoHS <- nhanes %>%
        mutate(HS_Category = ifelse(str_detect(Education, "th"), "Less than HS", "HS or More")) %>% 
        filter(HS_Category == "Less than HS" & !is.na(TotChol)) %>% 
        group_by(Gender) %>% 
        summarize(meanexp=mean(TotChol))
      
      nhanes_NoHS
    
    #str_which - Find the indexes of strings that contain a pattern match.
      str_which(nhanes$Education, "th")
    
    #str_count - Count the number of matches in a string.
      str_count(nhanes$Education, "h")
      
    #str_locate - Shows the location of the pattern matches in a string
      str_locate(nhanes$Education, "th")
      str_locate_all(nhanes$Education, "h")/
      
  #Subset strings
    #str_sub - Extract substrings from a character vector.
      str_sub("Here is a substring, let us look at it.", 11, 19)
      str_sub(nhanes$Education, 3, 5)
      
      # You can also assign character vectors to a substring
      str_sub(nhanes$Gender, 7, 8) <- "" 
      n_distinct(nhanes$Gender)
      
    #str_subset - Return only the strings that contain a pattern match.
      str_subset("Here is a substring, let us look at it", "substring")
      str_subset(nhanes$Race, "ite")
  
      #### String Exercise 1 #####
      #1. Create the string vector "This is a test string for us to look at in this exercise, tell me what you can find."  
         # Using str_detect, check whether the following strings or patterns are found.
         #  a. "ell"
         #  b. "Exe"
         #  c. "!"
         #  d. "[:digit:]"
      
      str_detect("This is a test string for us to look at in this exercise, tell me what you can find.", "ell")
      str_detect("This is a test string for us to look at in this exercise, tell me what you can find.", "Exe")
      str_detect("This is a test string for us to look at in this exercise, tell me what you can find.", "!")
      str_detect("This is a test string for us to look at in this exercise, tell me what you can find.", "[:digit:]")
      #2. Create a substring within the nhanes dataset for RelationshipStatus that starts at the first character and is 4 characters long.
        
      str_sub(nhanes$RelationshipStatus, 1, 4)
        
      #3. Filter the nhanes dataset by patients that have an "a" or "A" in the Race variable. Select the Age and Race columns.
      
      nhanes %>% 
        filter(str_detect(Race, "A") | str_detect(Race, "a")) %>%
        select(Age, Race)
        
      #--------------------------#
      
  #Manage Lengths
    #str_length - Find the length of a string
      str_length("How long is this string")
      ifelse(str_length("How long is this string") > 20, "String is long", "String is not long")
      
    #str_trim - Trims away white spaces from the beginning and end of a string
      str_trim("   This has       too much    space  ")
      str_trim("   Author: David Martin")
      
    #str_squish - Trims extra white space from the beginning, middle, and end of a sentence
      str_squish("   This still has       too much    space  ")
      str_squish("   Address: 2312 Main Street,    City: Charlottesville,   State:  Virginia  ")
      
   #Mutate Strings
    #str_replace() - Replace the first matched pattern in each string.
      str_replace("First time is is here replace is with is replacer", "is", "REPLACE")
      
      n_distinct(nhanes$Gender)
      
      nhanes$Gender <- nhanes$Gender %>% 
        str_replace("r", "")
      
      n_distinct(nhanes$Gender)
      
    #str_replace_all() - Replace all matched patterns in each string.
      str_replace_all("First time is is here replace is with is replacer", "is", "REPLACE")
      
      n_distinct(nhanes$Gender)
      
      nhanes$Gender <- nhanes$Gender %>% 
                        str_replace_all("u", "")
      
      n_distinct(nhanes$Gender)
      n_distinct(nhanes$Education)
      
      nhanes$Education <- nhanes$Education %>% 
          str_replace_all(c("th" = "", "Grad" = "", "grad" = "", " e" = "", "Only" = "", "uate" = "")) %>% 
      str_trim() %>%
        str_squish
      
      head(nhanes$Education, 20)
      n_distinct(nhanes$Education)
    
    #str_to_lower() - set all characters in string to lowercase
      str_to_lower("STOP SHOUTING AT ME NOW")
      nhanes$Gender <- str_to_lower(nhanes$Gender)
      n_distinct(nhanes$Gender)
      head(nhanes$Gender, 50)
      
    #str_to_upper() - set all characters in string to uppercase
      str_to_upper("please speak up")
      str_to_upper(nhanes$Education)
      
    #str_to_title() - - set the first character in string to uppercase
      str_to_title("an introduction to r by: DAVID MARTIN")
      nhanes$Education <- str_to_title(nhanes$Education)
      n_distinct(nhanes$Education)
      head(nhanes$Education, 40)
      
      #Compare the 3 modifiers
      str_vec <- "How does THIS look?"
      
      str_vec %>% 
          str_to_lower()
          
      str_vec %>% 
        str_to_upper()
      
      str_vec %>% 
        str_to_title()
 
      #--------------------------#
#Merging/Appending/Reshaping Data
    # rbind, cbind
    new_var <- 1
    # Bind Columns
    cbind(new_var, 1:7)
    
    # Bind Rows
    rbind(new_var, 1:7)
    cbind(new_var, rbind(new_var, 1:7))
    
    id       <- c(1, 2, 3, 4)
    mean_var <- c(3, 6, 9, 12)
    df1 <- data.frame(id, mean_var)
    sd_var   <- c(.7, 1.6, .3, 2.1)
    cbind(df1, sd_var)
    
    #Full Join
    df2 <- data.frame(id, sd_var)
    full_join(df1, df2, by = "id")
    
    df3 <- data.frame(c("male", "female"), c(500, 250))
      colnames(df3) <- c("Gender", "Extra_variable")
    
    nhanes <- inner_join(nhanes, df3, by = "Gender")
    
    # Gather/Spread
    nhanes <- select(nhanes, -PhysActiveDays)
    final_nhanes <- select(nhanes, c(1:35))
    nrow(final_nhanes)
    final_nhanes <- spread(final_nhanes, visit_num, PhysActive, sep = "_")
    
    View(final_nhanes)
    nrow(final_nhanes)
    
    #Save Final CSV.
    write.csv(final_nhanes, "nhanes_final.csv")
    