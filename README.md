README
================
Monica Weedman
2024-09-23

## PsyClean is an R package with functions that facilitate easier cleaning of human participant data

The PsyClean package is available to download from Github.

1.  Install the devtools package from CRAN. You can skip this step if
    you’ve used this package before.

``` r
install.packages("devtools")
```

2.  Load the devtools package.

``` r
library(devtools)
```

3.  Install PsyClean using install_github(“author name/package name”).

``` r
install_github("monica-weedman/PsyClean")
```

4.  Load PsyClean.

``` r
library(PsyClean)
```

#### Example data

``` r
#Create an example dataframe 
ex_df <- data.frame(
  participantID = c(45628,86715,45579,25321,89952,44371,94271,30456,11853,26074),
  IPAddress = c("129.62.70.247","129.62.70.101","107.122.245.26","104.251.212.62","129.62.70.255","41.60.232.255","102.89.32.52","5.62.49.115","129.62.70.237","129.62.70.119"),
  Q_RecaptchaScore = c(0.232, 0.899, 0.899, 0.566, 0.899,0.100, 0.556,0.788,0.225,0.667),
  Q_RelevantIDFraudScore = c(70, 0, 10, 35, 0, 90, 25, 15,75,15),
  emo_1 = c(1,NA, 4, 5, 2, 2, 3,1,4,2),
  emo_2 = c(2,2,4,4,1,3,3,3,1,4),
  emo_3 = c(5,5,2,2,4,4,2,5,5,2),
  gender = rep(c("Man","Woman"),each=5)
)
print(ex_df)
```

    ##    participantID      IPAddress Q_RecaptchaScore Q_RelevantIDFraudScore emo_1
    ## 1          45628  129.62.70.247            0.232                     70     1
    ## 2          86715  129.62.70.101            0.899                      0    NA
    ## 3          45579 107.122.245.26            0.899                     10     4
    ## 4          25321 104.251.212.62            0.566                     35     5
    ## 5          89952  129.62.70.255            0.899                      0     2
    ## 6          44371  41.60.232.255            0.100                     90     2
    ## 7          94271   102.89.32.52            0.556                     25     3
    ## 8          30456    5.62.49.115            0.788                     15     1
    ## 9          11853  129.62.70.237            0.225                     75     4
    ## 10         26074  129.62.70.119            0.667                     15     2
    ##    emo_2 emo_3 gender
    ## 1      2     5    Man
    ## 2      2     5    Man
    ## 3      4     2    Man
    ## 4      4     2    Man
    ## 5      1     4    Man
    ## 6      3     4  Woman
    ## 7      3     2  Woman
    ## 8      3     5  Woman
    ## 9      1     5  Woman
    ## 10     4     2  Woman

``` r
#Create an example dataframe where row 1 is a descriptive text row (similar to what would be included in a .csv exported from a qualtrics survey)
description_row <- data.frame(
  participantID = "participantID",
  IPAddress = "IP Address",
  Q_RecaptchaScore = "Q_RecaptchaScore",
  Q_RelevantIDFraudScore = "Q_RelevantIDFraudScore",
  emo_1 = "Please rate the extent to which you experienced the following emotions while reading the passage. - Happiness",
  emo_2 = "Please rate the extent to which you experienced the following emotions while reading the passage. - Enjoyment",
  emo_3 = "Please rate the extent to which you experienced the following emotions while reading the passage. - Sadness",
  gender = "What is your gender? - Selected Choice"
)
ex2_df <- rbind(description_row, ex_df)
print(ex2_df)
```

    ##    participantID      IPAddress Q_RecaptchaScore Q_RelevantIDFraudScore
    ## 1  participantID     IP Address Q_RecaptchaScore Q_RelevantIDFraudScore
    ## 2          45628  129.62.70.247            0.232                     70
    ## 3          86715  129.62.70.101            0.899                      0
    ## 4          45579 107.122.245.26            0.899                     10
    ## 5          25321 104.251.212.62            0.566                     35
    ## 6          89952  129.62.70.255            0.899                      0
    ## 7          44371  41.60.232.255              0.1                     90
    ## 8          94271   102.89.32.52            0.556                     25
    ## 9          30456    5.62.49.115            0.788                     15
    ## 10         11853  129.62.70.237            0.225                     75
    ## 11         26074  129.62.70.119            0.667                     15
    ##                                                                                                            emo_1
    ## 1  Please rate the extent to which you experienced the following emotions while reading the passage. - Happiness
    ## 2                                                                                                              1
    ## 3                                                                                                           <NA>
    ## 4                                                                                                              4
    ## 5                                                                                                              5
    ## 6                                                                                                              2
    ## 7                                                                                                              2
    ## 8                                                                                                              3
    ## 9                                                                                                              1
    ## 10                                                                                                             4
    ## 11                                                                                                             2
    ##                                                                                                            emo_2
    ## 1  Please rate the extent to which you experienced the following emotions while reading the passage. - Enjoyment
    ## 2                                                                                                              2
    ## 3                                                                                                              2
    ## 4                                                                                                              4
    ## 5                                                                                                              4
    ## 6                                                                                                              1
    ## 7                                                                                                              3
    ## 8                                                                                                              3
    ## 9                                                                                                              3
    ## 10                                                                                                             1
    ## 11                                                                                                             4
    ##                                                                                                          emo_3
    ## 1  Please rate the extent to which you experienced the following emotions while reading the passage. - Sadness
    ## 2                                                                                                            5
    ## 3                                                                                                            5
    ## 4                                                                                                            2
    ## 5                                                                                                            2
    ## 6                                                                                                            4
    ## 7                                                                                                            4
    ## 8                                                                                                            2
    ## 9                                                                                                            5
    ## 10                                                                                                           5
    ## 11                                                                                                           2
    ##                                    gender
    ## 1  What is your gender? - Selected Choice
    ## 2                                     Man
    ## 3                                     Man
    ## 4                                     Man
    ## 5                                     Man
    ## 6                                     Man
    ## 7                                   Woman
    ## 8                                   Woman
    ## 9                                   Woman
    ## 10                                  Woman
    ## 11                                  Woman

## Functions

### createcb()

**createcb** creates a codebook from an existing dataframe with the
following columns: Variable, Alias, Description, Scoring, Citation. The
Variable column will be filled with variable names from the header row
of the dataframe. The Description column will be filled with the text
description of the variable provided in the first row of the dataframe.
Returns the original dataframe with the description row removed.

#### Usage

createcb(data, headers=TRUE, cbname=“codebook”)

#### Arguments

*data* = Dataframe or matrix of data

*headers* = Dataframe conrains header row; Default = TRUE

*cbname* = Name of codebook to be created; Default = “codebook”

#### Example

``` r
ex2_df <- createcb(data=ex2_df)
head(ex2_df)
```

    ##   participantID      IPAddress Q_RecaptchaScore Q_RelevantIDFraudScore emo_1
    ## 2         45628  129.62.70.247            0.232                     70     1
    ## 3         86715  129.62.70.101            0.899                      0  <NA>
    ## 4         45579 107.122.245.26            0.899                     10     4
    ## 5         25321 104.251.212.62            0.566                     35     5
    ## 6         89952  129.62.70.255            0.899                      0     2
    ## 7         44371  41.60.232.255              0.1                     90     2
    ##   emo_2 emo_3 gender
    ## 2     2     5    Man
    ## 3     2     5    Man
    ## 4     4     2    Man
    ## 5     4     2    Man
    ## 6     1     4    Man
    ## 7     3     4  Woman

``` r
print(codebook)
```

    ##                 Variable Alias
    ## 1          participantID      
    ## 2              IPAddress      
    ## 3       Q_RecaptchaScore      
    ## 4 Q_RelevantIDFraudScore      
    ## 5                  emo_1      
    ## 6                  emo_2      
    ## 7                  emo_3      
    ## 8                 gender      
    ##                                                                                                     Description
    ## 1                                                                                                 participantID
    ## 2                                                                                                    IP Address
    ## 3                                                                                              Q_RecaptchaScore
    ## 4                                                                                        Q_RelevantIDFraudScore
    ## 5 Please rate the extent to which you experienced the following emotions while reading the passage. - Happiness
    ## 6 Please rate the extent to which you experienced the following emotions while reading the passage. - Enjoyment
    ## 7   Please rate the extent to which you experienced the following emotions while reading the passage. - Sadness
    ## 8                                                                        What is your gender? - Selected Choice
    ##   Scoring Citation
    ## 1                 
    ## 2                 
    ## 3                 
    ## 4                 
    ## 5                 
    ## 6                 
    ## 7                 
    ## 8

### ip_check()

**ip_check** works with the IPHub.info API (<https://iphub.info/api>) to
quickly scan IP addresses for origin and type. Returns dataframe with
two appended vectors: *IPcountry* \[2-letter country code associated
with IP address\] and *IPflag* \[IPHub block parameter denoting IP
address as 0 = residential or business IP (safe), 1 = Non-residential IP
(hosting provider, proxy), or 2 = Non-residential & residential IP
(mixed)\].

#### Imports

httr (<https://cran.r-project.org/web/packages/httr/index.html>)

#### Usage

ip_check(data, ip, api_key, updatecb=TRUE, cbname=“codebook”)

#### Arguments

*data* = Dataframe or matrix of data

*ip* = Name of variable containing IP addresses to check, written as a
string (within double-quotes)

*api_key* = Your API key obtained from IPHub.info (register for an API
key here: <https://iphub.info/register>), written as a string

*updatecb* = Updates codebook with new IPcheck and IPflag variables;
Default = TRUE

*cbname* = Name of codebook to be updated; Default = “codebook”

#### Examples

``` r
ex2_df <- ip_check(ex_df, ip="IPAddress",api_key="MYAPIKEY")
```

``` r
print(ex2_df)
```

    ##    participantID      IPAddress Q_RecaptchaScore Q_RelevantIDFraudScore emo_1
    ## 2          45628  129.62.70.247            0.232                     70     1
    ## 3          86715  129.62.70.101            0.899                      0  <NA>
    ## 4          45579 107.122.245.26            0.899                     10     4
    ## 5          25321 104.251.212.62            0.566                     35     5
    ## 6          89952  129.62.70.255            0.899                      0     2
    ## 7          44371  41.60.232.255              0.1                     90     2
    ## 8          94271   102.89.32.52            0.556                     25     3
    ## 9          30456    5.62.49.115            0.788                     15     1
    ## 10         11853  129.62.70.237            0.225                     75     4
    ## 11         26074  129.62.70.119            0.667                     15     2
    ##    emo_2 emo_3 gender IPcountry IPflag
    ## 2      2     5    Man        US      0
    ## 3      2     5    Man        US      0
    ## 4      4     2    Man        US      0
    ## 5      4     2    Man        US      1
    ## 6      1     4    Man        US      0
    ## 7      3     4  Woman        ZM      0
    ## 8      3     2  Woman        NG      0
    ## 9      3     5  Woman        US      1
    ## 10     1     5  Woman        US      0
    ## 11     4     2  Woman        US      0

``` r
print(codebook)
```

    ##                  Variable Alias
    ## 1           participantID      
    ## 2               IPAddress      
    ## 3        Q_RecaptchaScore      
    ## 4  Q_RelevantIDFraudScore      
    ## 5                   emo_1      
    ## 6                   emo_2      
    ## 7                   emo_3      
    ## 8                  gender      
    ## 9                  IPflag  <NA>
    ## 10              IPcountry  <NA>
    ##                                                                                                      Description
    ## 1                                                                                                  participantID
    ## 2                                                                                                     IP Address
    ## 3                                                                                               Q_RecaptchaScore
    ## 4                                                                                         Q_RelevantIDFraudScore
    ## 5  Please rate the extent to which you experienced the following emotions while reading the passage. - Happiness
    ## 6  Please rate the extent to which you experienced the following emotions while reading the passage. - Enjoyment
    ## 7    Please rate the extent to which you experienced the following emotions while reading the passage. - Sadness
    ## 8                                                                         What is your gender? - Selected Choice
    ## 9                                                                             IP address type using IPhub schema
    ## 10                                                                                  IP address country of origin
    ##                              Scoring   Citation
    ## 1                                              
    ## 2                                              
    ## 3                                              
    ## 4                                              
    ## 5                                              
    ## 6                                              
    ## 7                                              
    ## 8                                              
    ## 9  0= good, 1 = poor/proxy, 2= mixed iphub.info
    ## 10          2-character country code iphub.info

### tbe()

**tbe** stands for “to be excluded” and can be used to create or update
a filter variable to indicate cases that should be excluded and create
or update a variable annotating the reason for their exclusion. Returns
dataframe with exclusion variables based on provided criteria.

#### Usage

tbe(data, var1, val1, v1prime = FALSE, var2, val2, v2prime = FALSE,
intersect = FALSE, updatecb=TRUE, cbname=“codebook”)

#### Arguments

*data* = Dataframe or matrix of data

*var1* = Name of variable to assess (must be enclosed in double quotes)

*val1* = Value of var1 to filter

*v1prime* = Default = FALSE = excludes cases where var1 = val1; TRUE =
excludes cases where var1 ≠ val1

*var2* = Name of variable to assess (must be enclosed in double quotes)

*val2* = Value of var2 to filter

*v2prime* = Default = FALSE = excludes cases where var2 = val2; TRUE =
excludes cases where var2 ≠ val2

*intersect* = Default = FALSE = excludes cases meeting criteria for var1
OR var2; TRUE = excludes cases meeting criteria for var1 AND var2

*updatecb* = Updates codebook with new exclusion variables; Default =
TRUE

*cbname* = Name of codebook to be updated; Default = “codebook”

#### Examples

``` r
#To exclude cases with non-US IP addresses (IPcountry !="US") OR poor/proxy IP addresses (IPflag = 1)
ex2_df <- tbe(ex2_df, var1="IPcountry", val1="US", v1prime=TRUE, var2="IPflag", val2=1)
```

    ## Codebook updated with exclusion variables.

``` r
print(ex2_df)
```

    ##    participantID      IPAddress Q_RecaptchaScore Q_RelevantIDFraudScore emo_1
    ## 2          45628  129.62.70.247            0.232                     70     1
    ## 3          86715  129.62.70.101            0.899                      0  <NA>
    ## 4          45579 107.122.245.26            0.899                     10     4
    ## 5          25321 104.251.212.62            0.566                     35     5
    ## 6          89952  129.62.70.255            0.899                      0     2
    ## 7          44371  41.60.232.255              0.1                     90     2
    ## 8          94271   102.89.32.52            0.556                     25     3
    ## 9          30456    5.62.49.115            0.788                     15     1
    ## 10         11853  129.62.70.237            0.225                     75     4
    ## 11         26074  129.62.70.119            0.667                     15     2
    ##    emo_2 emo_3 gender IPcountry IPflag exclude IPcountry_fail IPflag_fail
    ## 2      2     5    Man        US      0   FALSE          FALSE       FALSE
    ## 3      2     5    Man        US      0   FALSE          FALSE       FALSE
    ## 4      4     2    Man        US      0   FALSE          FALSE       FALSE
    ## 5      4     2    Man        US      1    TRUE          FALSE        TRUE
    ## 6      1     4    Man        US      0   FALSE          FALSE       FALSE
    ## 7      3     4  Woman        ZM      0    TRUE           TRUE       FALSE
    ## 8      3     2  Woman        NG      0    TRUE           TRUE       FALSE
    ## 9      3     5  Woman        US      1    TRUE          FALSE        TRUE
    ## 10     1     5  Woman        US      0   FALSE          FALSE       FALSE
    ## 11     4     2  Woman        US      0   FALSE          FALSE       FALSE

``` r
print(codebook)
```

    ##                  Variable Alias
    ## 1           participantID      
    ## 2               IPAddress      
    ## 3        Q_RecaptchaScore      
    ## 4  Q_RelevantIDFraudScore      
    ## 5                   emo_1      
    ## 6                   emo_2      
    ## 7                   emo_3      
    ## 8                  gender      
    ## 9                  IPflag  <NA>
    ## 10              IPcountry  <NA>
    ## 11         IPcountry_fail  <NA>
    ## 12            IPflag_fail  <NA>
    ##                                                                                                      Description
    ## 1                                                                                                  participantID
    ## 2                                                                                                     IP Address
    ## 3                                                                                               Q_RecaptchaScore
    ## 4                                                                                         Q_RelevantIDFraudScore
    ## 5  Please rate the extent to which you experienced the following emotions while reading the passage. - Happiness
    ## 6  Please rate the extent to which you experienced the following emotions while reading the passage. - Enjoyment
    ## 7    Please rate the extent to which you experienced the following emotions while reading the passage. - Sadness
    ## 8                                                                         What is your gender? - Selected Choice
    ## 9                                                                             IP address type using IPhub schema
    ## 10                                                                                  IP address country of origin
    ## 11                                                                              exclusion variable for IPcountry
    ## 12                                                                                 exclusion variable for IPflag
    ##                              Scoring   Citation
    ## 1                                              
    ## 2                                              
    ## 3                                              
    ## 4                                              
    ## 5                                              
    ## 6                                              
    ## 7                                              
    ## 8                                              
    ## 9  0= good, 1 = poor/proxy, 2= mixed iphub.info
    ## 10          2-character country code iphub.info
    ## 11  TRUE = failed inclusion criteria       <NA>
    ## 12  TRUE = failed inclusion criteria       <NA>

### fraud_check()

**fraud_check** is a more specific version of tbe() which is intended to
be used to create or update a filter variable to indicate cases meeting
bot/security check criteria. This function is intended to be used with
bot/security variables supported by Qualtrics (reCAPTCHA, RelevantID).
Returns dataframe with columns “CAPTCHA_fail” and “RelID_fail”
indicating pass or fail of Q_RecaptchaScore and Q_RelevantIDFraudScore
measures.

#### Usage

fraud_check(data, recaptcha = “Q_RecaptchaScore”, relID =
“Q_RelevantIDFraudScore”, rclimit =.5, relIDlimit = 30, intersect =
FALSE, updatecb=TRUE, cbname=“codebook”)

#### Arguments

*data* = Dataframe or matrix of data

*recaptcha* = Name of reCAPTCHA variable; Default = “Q_RecaptchaScore”,
assuming Qualitrics naming scheme (must be enclosed in double quotes)

*relID* = Name of RelevantID fraud variable; Default =
“Q_RelevantIDFraudScore”, assuming Qualtrics naming scheme (must be
enclosed in double quotes)

*rclimit* = reCAPTCHA threshold used for exclusion; Default = 0.5; cases
scoring less than this value will be excluded

*relIDlimit* = RelevantID theshold used for exclusion; Default = 30;
cases scoring greater than or equal to this value will be excluded

*intersect* = Default = FALSE = excludes cases meeting criteria for
recaptcha OR relID; TRUE = excludes cases meeting criteria for recaptcha
AND relID

*updatecb* = Uupdates codebook with new exclusion variables; Default =
TRUE

*cbname* = Name of codebook to be updated; Default = “codebook”

#### Examples

``` r
#To exclude cases where reCAPTCHA is less than 0.5 (default) AND RelevantID is greater than or equal to 30 (default)
ex2_df <- fraud_check(ex2_df, intersect=TRUE)
```

    ## Codebook updated with exclusion variables.

``` r
print(ex2_df)
```

    ##    participantID      IPAddress Q_RecaptchaScore Q_RelevantIDFraudScore emo_1
    ## 2          45628  129.62.70.247            0.232                     70     1
    ## 3          86715  129.62.70.101            0.899                      0  <NA>
    ## 4          45579 107.122.245.26            0.899                     10     4
    ## 5          25321 104.251.212.62            0.566                     35     5
    ## 6          89952  129.62.70.255            0.899                      0     2
    ## 7          44371  41.60.232.255              0.1                     90     2
    ## 8          94271   102.89.32.52            0.556                     25     3
    ## 9          30456    5.62.49.115            0.788                     15     1
    ## 10         11853  129.62.70.237            0.225                     75     4
    ## 11         26074  129.62.70.119            0.667                     15     2
    ##    emo_2 emo_3 gender IPcountry IPflag exclude IPcountry_fail IPflag_fail
    ## 2      2     5    Man        US      0    TRUE          FALSE       FALSE
    ## 3      2     5    Man        US      0   FALSE          FALSE       FALSE
    ## 4      4     2    Man        US      0   FALSE          FALSE       FALSE
    ## 5      4     2    Man        US      1    TRUE          FALSE        TRUE
    ## 6      1     4    Man        US      0   FALSE          FALSE       FALSE
    ## 7      3     4  Woman        ZM      0    TRUE           TRUE       FALSE
    ## 8      3     2  Woman        NG      0    TRUE           TRUE       FALSE
    ## 9      3     5  Woman        US      1    TRUE          FALSE        TRUE
    ## 10     1     5  Woman        US      0    TRUE          FALSE       FALSE
    ## 11     4     2  Woman        US      0   FALSE          FALSE       FALSE
    ##    CAPTCHA_fail relID_fail
    ## 2          TRUE       TRUE
    ## 3         FALSE      FALSE
    ## 4         FALSE      FALSE
    ## 5         FALSE       TRUE
    ## 6         FALSE      FALSE
    ## 7          TRUE       TRUE
    ## 8         FALSE      FALSE
    ## 9         FALSE      FALSE
    ## 10         TRUE       TRUE
    ## 11        FALSE      FALSE

``` r
print(codebook)
```

    ##                  Variable Alias
    ## 1           participantID      
    ## 2               IPAddress      
    ## 3        Q_RecaptchaScore      
    ## 4  Q_RelevantIDFraudScore      
    ## 5                   emo_1      
    ## 6                   emo_2      
    ## 7                   emo_3      
    ## 8                  gender      
    ## 9                  IPflag  <NA>
    ## 10              IPcountry  <NA>
    ## 11         IPcountry_fail  <NA>
    ## 12            IPflag_fail  <NA>
    ## 13           CAPTCHA_fail  <NA>
    ## 14             relID_fail  <NA>
    ##                                                                                                      Description
    ## 1                                                                                                  participantID
    ## 2                                                                                                     IP Address
    ## 3                                                                                               Q_RecaptchaScore
    ## 4                                                                                         Q_RelevantIDFraudScore
    ## 5  Please rate the extent to which you experienced the following emotions while reading the passage. - Happiness
    ## 6  Please rate the extent to which you experienced the following emotions while reading the passage. - Enjoyment
    ## 7    Please rate the extent to which you experienced the following emotions while reading the passage. - Sadness
    ## 8                                                                         What is your gender? - Selected Choice
    ## 9                                                                             IP address type using IPhub schema
    ## 10                                                                                  IP address country of origin
    ## 11                                                                              exclusion variable for IPcountry
    ## 12                                                                                 exclusion variable for IPflag
    ## 13                                                                       exclusion variable for Q_RecaptchaScore
    ## 14                                                                 exclusion variable for Q_RelevantIDFraudScore
    ##                                                          Scoring   Citation
    ## 1                                                                          
    ## 2                                                                          
    ## 3                                                                          
    ## 4                                                                          
    ## 5                                                                          
    ## 6                                                                          
    ## 7                                                                          
    ## 8                                                                          
    ## 9                              0= good, 1 = poor/proxy, 2= mixed iphub.info
    ## 10                                      2-character country code iphub.info
    ## 11                              TRUE = failed inclusion criteria       <NA>
    ## 12                              TRUE = failed inclusion criteria       <NA>
    ## 13       TRUE = failed inclusion criteria Q_RecaptchaScore < 0.5       <NA>
    ## 14 TRUE = failed inclusion criteria Q_RelevantIDFraudScore >= 30       <NA>

### rename()

**rename** can be used to rename variables and update variable names in
a codebook.

#### Usage

rename(data, old, new, updatecb=TRUE, cbname=“codebook”)

#### Arguments

*data* = Dataframe or matrix of data

*old* = Name of variable to be renamed, written as a string (within
quotes)

*new* = New name of variable, written as a string (within quotes)

*updatecb* = Default = TRUE = updates codebook by replacing old variable
name with new variable name in Variable column and copying old variable
name to Alias column

*cbname* = Default = “codebook” = Name of codebook to be updated

#### Example

``` r
ex2_df <- rename(data=ex2_df, old="emo_1", new="happy")
ex2_df <- rename(data=ex2_df, old="emo_2", new="enjoy")
ex2_df <- rename(data=ex2_df, old="emo_3", new="sad")

colnames(ex2_df)
```

    ##  [1] "participantID"          "IPAddress"              "Q_RecaptchaScore"      
    ##  [4] "Q_RelevantIDFraudScore" "happy"                  "enjoy"                 
    ##  [7] "sad"                    "gender"                 "IPcountry"             
    ## [10] "IPflag"                 "exclude"                "IPcountry_fail"        
    ## [13] "IPflag_fail"            "CAPTCHA_fail"           "relID_fail"

``` r
print(codebook)
```

    ##                  Variable Alias
    ## 1           participantID      
    ## 2               IPAddress      
    ## 3        Q_RecaptchaScore      
    ## 4  Q_RelevantIDFraudScore      
    ## 5                   happy emo_1
    ## 6                   enjoy emo_2
    ## 7                     sad emo_3
    ## 8                  gender      
    ## 9                  IPflag  <NA>
    ## 10              IPcountry  <NA>
    ## 11         IPcountry_fail  <NA>
    ## 12            IPflag_fail  <NA>
    ## 13           CAPTCHA_fail  <NA>
    ## 14             relID_fail  <NA>
    ##                                                                                                      Description
    ## 1                                                                                                  participantID
    ## 2                                                                                                     IP Address
    ## 3                                                                                               Q_RecaptchaScore
    ## 4                                                                                         Q_RelevantIDFraudScore
    ## 5  Please rate the extent to which you experienced the following emotions while reading the passage. - Happiness
    ## 6  Please rate the extent to which you experienced the following emotions while reading the passage. - Enjoyment
    ## 7    Please rate the extent to which you experienced the following emotions while reading the passage. - Sadness
    ## 8                                                                         What is your gender? - Selected Choice
    ## 9                                                                             IP address type using IPhub schema
    ## 10                                                                                  IP address country of origin
    ## 11                                                                              exclusion variable for IPcountry
    ## 12                                                                                 exclusion variable for IPflag
    ## 13                                                                       exclusion variable for Q_RecaptchaScore
    ## 14                                                                 exclusion variable for Q_RelevantIDFraudScore
    ##                                                          Scoring   Citation
    ## 1                                                                          
    ## 2                                                                          
    ## 3                                                                          
    ## 4                                                                          
    ## 5                                                                          
    ## 6                                                                          
    ## 7                                                                          
    ## 8                                                                          
    ## 9                              0= good, 1 = poor/proxy, 2= mixed iphub.info
    ## 10                                      2-character country code iphub.info
    ## 11                              TRUE = failed inclusion criteria       <NA>
    ## 12                              TRUE = failed inclusion criteria       <NA>
    ## 13       TRUE = failed inclusion criteria Q_RecaptchaScore < 0.5       <NA>
    ## 14 TRUE = failed inclusion criteria Q_RelevantIDFraudScore >= 30       <NA>

### rescore()

**rescore** can be used to rescore or reverse score variables.

#### Usage

rescore(data, vars, old, new = NULL, updatecb = TRUE, cbname =
“codebook”)

#### Arguments

*data* = Dataframe or matrix of data

*vars* = Name of variable or list of variables to be rescored, written
as string

*old* = List of current values held in vars

*new* = Default = NULL; List of new values to replace old values. If
excluded, vars will be reverse scored using old values.

*updatecb* = Updates codebook with name of rescored scored variable;
Default = TRUE

*cbname* = Name of codebook to be updated; Default = “codebook”

#### Example

``` r
#Reverse-score "sad"
ex2_df <- rescore(data=ex2_df, vars="sad", old=c(1,2,3,4,5))
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following object is masked from 'package:PsyClean':
    ## 
    ##     rename

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
#Rescore "happy" and "enjoy" to new scheme: -2, -1, 0, 1, 2
ex2_df <- rescore(data=ex2_df, vars=c("happy","enjoy"), old=c(1,2,3,4,5), new=c(-2,-1,0,1,2))
```

### scalescore()

**scalescore** can be used to create sum or mean scores across several
items.

#### Usage

scalescore(data, items, method = “mean”, newvar, measure, updatecb =
TRUE, cbname = “codebook”, cite)

#### Arguments

*data* = Dataframe or matrix of data

*items* = List of items to be combined into a scale score

*method* = Default = “mean”; method to create scale score across items,
can also take “sum”

*newvar* = Name of new variable to be created

*measure* = Name of measure to be added to codebook for new variable, if
applicable

*updatecb* = Updates codebook with new variable; Default = TRUE

*cbname* = Name of codebook to be updated; Default = “codebook”

*cite* = Citation for measure to ve added to codebook, if applicable

#### Example

``` r
#mean of "happy" and "enjoy"
ex2_df <- scalescore(ex2_df, items=c("happy","enjoy"), newvar="positive_emo", measure="Positive Emotion Scale", cite="Weedman et al. (2024)")
```

    ## Codebook updated with new scored variable.

### extreme()

**extreme** can be used to identify and exclude outliers on specified
variables.

#### Usage

extreme(data, var, threshold, exclude=FALSE)

#### Arguments

*data* = Dataframe or matrix of data

*var* = Name of variable to check for outliers (must be enclosed in
double quotes)

*threshold* = Number in standard deviation units to act as upper and
lower bound for outliers

*exclude* = Default = FALSE = returns list of outliers but does not
remove from data; TRUE = returns data with outliers removed

#### Examples

    ## here() starts at /Users/monicaweedman/Desktop/PsyClean_package

``` r
#Example Data 2 (big_data) contains 737 cases on 2 variables: Religious Intellectual Humility (RIH_tot) and religious group-esteem (esteem_tot)
head(big_data)
```

    ##          ResponseId  RIH_tot esteem_tot
    ## 1 R_1rqLadYASD8eMkp 3.083333        4.0
    ## 2 R_2k6xvz5XlCfuOC1 3.916667        5.0
    ## 3 R_7AEr5vVWMlxCVm9 3.000000        2.5
    ## 4 R_8kgEMQNj9GcmK5k 3.416667        5.0
    ## 5 R_2UuaDX7PDze54Zj 4.166667        6.0
    ## 6 R_3nV1gsVGZM8J0cN 4.583333        7.0

``` r
nrow(big_data)
```

    ## [1] 737

``` r
#To identify (but not remove) cases with scores on religious intellectual humility more extreme than 3.29 SDs away from the mean 
extreme(big_data, "RIH_tot", threshold=3.29)
```

    ## [1] "Mean of RIH_tot : 3.98518769788195"
    ## [1] "Standard deviation of RIH_tot : 0.594577473390855"
    ## [1] "Cases exceeding 3.29 SDs from the mean: 2"

    ##            ResponseId  RIH_tot esteem_tot
    ## 188 R_2GNgGDQmnvoGJNh 1.916667          7
    ## 346 R_8bWypGs5akgIeG6 1.583333          7

``` r
nrow(big_data)
```

    ## [1] 737

``` r
#To identify (but not remove) cases with scores on religious group-esteem more extreme than 3 SDs away from the mean 
extreme(big_data, "esteem_tot", threshold=3)
```

    ## [1] "Mean of esteem_tot : 5.9331750339213"
    ## [1] "Standard deviation of esteem_tot : 1.23840896043629"
    ## [1] "Cases exceeding 3 SDs from the mean: 7"

    ##            ResponseId  RIH_tot esteem_tot
    ## 121 R_3XRetw6rKwvc1ZD 4.583333       1.00
    ## 128 R_5D53wTmz4dryIGB 3.333333       1.75
    ## 211 R_7cpaVeXB8wEx6wl 3.416667       2.00
    ## 405 R_7lSPWA9YDSFFdl0 3.083333       1.00
    ## 513 R_5BPIPseSroSPDoP 3.416667       1.75
    ## 534 R_87zJm3LzstO1Kwh 3.750000       2.00
    ## 676 R_5gHOa3KqymyGMof 4.750000       1.50

``` r
nrow(big_data)
```

    ## [1] 737

``` r
#To create a filtered dataframe with outliers (more extreme than 3.29 SDs from the mean) on religious intellectual humility excluded 
RIH_filtered <- extreme(big_data, "RIH_tot", threshold=3.29, exclude=TRUE)
```

    ## [1] "Mean of RIH_tot : 3.98518769788195"
    ## [1] "Standard deviation of RIH_tot : 0.594577473390855"
    ## [1] "Cases exceeding 3.29 SDs from the mean: 2"
    ## [1] "Returning data excluding extreme cases. Count: 735"

``` r
#To create a filtered dataframe with outliers (more extreme than 3.29 SDs from the mean) on religious intellectual humility AND religious group-esteem excluded 
RIH_esteem_filtered <- extreme(RIH_filtered, "esteem_tot", threshold=3.29, exclude=TRUE)
```

    ## [1] "Mean of esteem_tot : 5.93027210884354"
    ## [1] "Standard deviation of esteem_tot : 1.23884062086051"
    ## [1] "Cases exceeding 3.29 SDs from the mean: 5"
    ## [1] "Returning data excluding extreme cases. Count: 730"

### export()

**export** can be used to export data to .csv or .sav files

#### Usage

export(data, name, filetype = “csv”, version = “all”, idcols =
c(“IPAddress”,“LocationLatitude”,“LocationLongitude”,“ExternalReference”,“RecipientFirstName”,“RecipientLastName”,“RecipientEmail”),
usecb = TRUE,cbname = “codebook”, exportcb=TRUE)

#### Arguments

**data** = Dataframe or matrix of data

**name** = Path name for exported file(s)

**filetype** = Default = “csv”; “sav” exports data as .sav file (for use
in SPSS), “all” exports data as .csv and .sav files

**version** = Default = “all”; “annotated” exports de-identified data
with no exclusions, “clean” exports de-identified data with exclusions,
“plain” exports data in current format

**idcols** = List of column names containing identifying information to
exclude from clean and annotated exports; Default =
c(“IPAddress”,“LocationLatitude”,“LocationLongitude”,“ExternalReference”,“RecipientFirstName”,“RecipientLastName”,“RecipientEmail”)

**usecb** = Uses “Description” column in codebook as labels in .sav
exports; Default = TRUE

**cbname** = Name of codebook; Default = “codebook”

**exportcb** = Exports codebook as .csv; Default = TRUE

#### Example

``` r
export(ex2_df, "~/Downloads/ex2_df", filetype="all")
```

    ## Exported files: ~/Downloads/ex2_df_plain.csv, ~/Downloads/ex2_df_plain.sav, ~/Downloads/ex2_df_annotated.csv, ~/Downloads/ex2_df_annotated.sav, ~/Downloads/ex2_df_clean.csv, ~/Downloads/ex2_df_clean.sav,~/Downloads/ex2_df_codebook.csv
