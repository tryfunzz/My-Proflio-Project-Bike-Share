----------------------------------------------------------------Bike-Share Analysis-----------------------------------------------------------------------

###Packages & Libraries
> library(tidyverse)
── Attaching packages ──────────────── tidyverse 1.3.2 ──
✔ ggplot2 3.3.6     ✔ purrr   0.3.4
✔ tibble  3.1.8     ✔ dplyr   1.0.9
✔ tidyr   1.2.0     ✔ stringr 1.4.0
✔ readr   2.1.2     ✔ forcats 0.5.1
── Conflicts ─────────────────── tidyverse_conflicts() ──
✖ dplyr::filter() masks stats::filter()
✖ dplyr::lag()    masks stats::lag()
> library(janitor)

载入程辑包：‘janitor’

The following objects are masked from ‘package:stats’:

    chisq.test, fisher.test

> library(ggplot2)
> library(readr)
> library(scales)

载入程辑包：‘scales’

The following object is masked from ‘package:purrr’:

    discard 

The following object is masked from ‘package:readr’:

    col_factor

> library(lubridate)

载入程辑包：‘lubridate’

The following objects are masked from ‘package:base’:

    date, intersect, setdiff, union

> library(dplyr)
> library(geosphere)
> library(skimr)

###Load Dataset
#Load the closed Dataset
> trip <- read.csv("C:\\Users\\xs187\\Desktop\\Trip_Data\\202207-divvy-tripdata.csv")
> colnames(trip)
 [1] "ride_id"            "rideable_type"     
 [3] "started_at"         "ended_at"          
 [5] "start_station_name" "start_station_id"  
 [7] "end_station_name"   "end_station_id"    
 [9] "start_lat"          "start_lng"         
[11] "end_lat"            "end_lng"           
[13] "member_casual"

#Glimpse the data (Insight how is  the data organized)
> str(trip)
'data.frame':	823488 obs. of  13 variables:
 $ ride_id           : chr  "954144C2F67B1932" "292E027607D218B6" "57765852588AD6E0" "B5B6BE44314590E6" ...
 $ rideable_type     : chr  "classic_bike" "classic_bike" "classic_bike" "classic_bike" ...
 $ started_at        : chr  "2022-07-05 08:12:47" "2022-07-26 12:53:38" "2022-07-03 13:58:49" "2022-07-31 17:44:21" ...
 $ ended_at          : chr  "2022-07-05 08:24:32" "2022-07-26 12:55:31" "2022-07-03 14:06:32" "2022-07-31 18:42:50" ...
 $ start_station_name: chr  "Ashland Ave & Blackhawk St" "Buckingham Fountain (Temp)" "Buckingham Fountain (Temp)" "Buckingham Fountain (Temp)" ...
 $ start_station_id  : chr  "13224" "15541" "15541" "15541" ...
 $ end_station_name  : chr  "Kingsbury St & Kinzie St" "Michigan Ave & 8th St" "Michigan Ave & 8th St" "Woodlawn Ave & 55th St" ...
 $ end_station_id    : chr  "KA1503000043" "623" "623" "TA1307000164" ...
 $ start_lat         : num  41.9 41.9 41.9 41.9 41.9 ...
 $ start_lng         : num  -87.7 -87.6 -87.6 -87.6 -87.6 ...
 $ end_lat           : num  41.9 41.9 41.9 41.8 41.9 ...
 $ end_lng           : num  -87.6 -87.6 -87.6 -87.6 -87.7 ...
 $ member_casual     : chr  "member" "casual" "casual" "casual" ...

> glimpse(trip)
Rows: 823,488
Columns: 13
$ ride_id            <chr> "954144C2F67B1932", "292E027…
$ rideable_type      <chr> "classic_bike", "classic_bik…
$ started_at         <chr> "2022-07-05 08:12:47", "2022…
$ ended_at           <chr> "2022-07-05 08:24:32", "2022…
$ start_station_name <chr> "Ashland Ave & Blackhawk St"…
$ start_station_id   <chr> "13224", "15541", "15541", "…
$ end_station_name   <chr> "Kingsbury St & Kinzie St", …
$ end_station_id     <chr> "KA1503000043", "623", "623"…
$ start_lat          <dbl> 41.90707, 41.86962, 41.86962…
$ start_lng          <dbl> -87.66725, -87.62398, -87.62…
$ end_lat            <dbl> 41.88918, 41.87277, 41.87277…
$ end_lng            <dbl> -87.63851, -87.62398, -87.62…
$ member_casual      <chr> "member", "casual", "casual"…

#Glimpse the data (Insight how is  the data organized)
> str(trip)
'data.frame':	823488 obs. of  13 variables:
 $ ride_id           : chr  "954144C2F67B1932" "292E027607D218B6" "57765852588AD6E0" "B5B6BE44314590E6" ...
 $ rideable_type     : chr  "classic_bike" "classic_bike" "classic_bike" "classic_bike" ...
 $ started_at        : chr  "2022-07-05 08:12:47" "2022-07-26 12:53:38" "2022-07-03 13:58:49" "2022-07-31 17:44:21" ...
 $ ended_at          : chr  "2022-07-05 08:24:32" "2022-07-26 12:55:31" "2022-07-03 14:06:32" "2022-07-31 18:42:50" ...
 $ start_station_name: chr  "Ashland Ave & Blackhawk St" "Buckingham Fountain (Temp)" "Buckingham Fountain (Temp)" "Buckingham Fountain (Temp)" ...
 $ start_station_id  : chr  "13224" "15541" "15541" "15541" ...
 $ end_station_name  : chr  "Kingsbury St & Kinzie St" "Michigan Ave & 8th St" "Michigan Ave & 8th St" "Woodlawn Ave & 55th St" ...
 $ end_station_id    : chr  "KA1503000043" "623" "623" "TA1307000164" ...
 $ start_lat         : num  41.9 41.9 41.9 41.9 41.9 ...
 $ start_lng         : num  -87.7 -87.6 -87.6 -87.6 -87.6 ...
 $ end_lat           : num  41.9 41.9 41.9 41.8 41.9 ...
 $ end_lng           : num  -87.6 -87.6 -87.6 -87.6 -87.7 ...
 $ member_casual     : chr  "member" "casual" "casual" "casual" ...

> glimpse(trip)
Rows: 823,488
Columns: 13
$ ride_id            <chr> "954144C2F67B1932", "292E027…
$ rideable_type      <chr> "classic_bike", "classic_bik…
$ started_at         <chr> "2022-07-05 08:12:47", "2022…
$ ended_at           <chr> "2022-07-05 08:24:32", "2022…
$ start_station_name <chr> "Ashland Ave & Blackhawk St"…
$ start_station_id   <chr> "13224", "15541", "15541", "…
$ end_station_name   <chr> "Kingsbury St & Kinzie St", …
$ end_station_id     <chr> "KA1503000043", "623", "623"…
$ start_lat          <dbl> 41.90707, 41.86962, 41.86962…
$ start_lng          <dbl> -87.66725, -87.62398, -87.62…
$ end_lat            <dbl> 41.88918, 41.87277, 41.87277…
$ end_lng            <dbl> -87.63851, -87.62398, -87.62…
$ member_casual      <chr> "member", "casual", "casual"…

###Data Import

#Combined the data (from August2021 to July2022)
> combined_trip <- list.files(path="C:\\Users\\xs187\\Desktop\\Trip_Data",full.names=TRUE) %>%
+   lapply(read_csv) %>%
+   bind_rows
Rows: 804352 Columns: 13                                                                    
── Column specification ─────────────────────────────────
Delimiter: ","
chr  (7): ride_id, rideable_type, start_station_name,...
dbl  (4): start_lat, start_lng, end_lat, end_lng
dttm (2): started_at, ended_at

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
Rows: 756147 Columns: 13                                                                    
── Column specification ─────────────────────────────────
Delimiter: ","
chr  (7): ride_id, rideable_type, start_station_name,...
dbl  (4): start_lat, start_lng, end_lat, end_lng
dttm (2): started_at, ended_at

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
Rows: 631226 Columns: 13                                                                    
── Column specification ─────────────────────────────────
Delimiter: ","
chr  (7): ride_id, rideable_type, start_station_name,...
dbl  (4): start_lat, start_lng, end_lat, end_lng
dttm (2): started_at, ended_at

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
Rows: 359978 Columns: 13                                                                    
── Column specification ─────────────────────────────────
Delimiter: ","
chr  (7): ride_id, rideable_type, start_station_name,...
dbl  (4): start_lat, start_lng, end_lat, end_lng
dttm (2): started_at, ended_at

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
Rows: 247540 Columns: 13                                                                    
── Column specification ─────────────────────────────────
Delimiter: ","
chr  (7): ride_id, rideable_type, start_station_name,...
dbl  (4): start_lat, start_lng, end_lat, end_lng
dttm (2): started_at, ended_at

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
Rows: 103770 Columns: 13                                                                    
── Column specification ─────────────────────────────────
Delimiter: ","
chr  (7): ride_id, rideable_type, start_station_name,...
dbl  (4): start_lat, start_lng, end_lat, end_lng
dttm (2): started_at, ended_at

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
Rows: 115609 Columns: 13                                                                    
── Column specification ─────────────────────────────────
Delimiter: ","
chr  (7): ride_id, rideable_type, start_station_name,...
dbl  (4): start_lat, start_lng, end_lat, end_lng
dttm (2): started_at, ended_at

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
Rows: 284042 Columns: 13                                                                    
── Column specification ─────────────────────────────────
Delimiter: ","
chr  (7): ride_id, rideable_type, start_station_name,...
dbl  (4): start_lat, start_lng, end_lat, end_lng
dttm (2): started_at, ended_at

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
Rows: 371249 Columns: 13                                                                    
── Column specification ─────────────────────────────────
Delimiter: ","
chr  (7): ride_id, rideable_type, start_station_name,...
dbl  (4): start_lat, start_lng, end_lat, end_lng
dttm (2): started_at, ended_at

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
Rows: 634858 Columns: 13                                                                    
── Column specification ─────────────────────────────────
Delimiter: ","
chr  (7): ride_id, rideable_type, start_station_name,...
dbl  (4): start_lat, start_lng, end_lat, end_lng
dttm (2): started_at, ended_at

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
Rows: 769204 Columns: 13                                                                    
── Column specification ─────────────────────────────────
Delimiter: ","
chr  (7): ride_id, rideable_type, start_station_name,...
dbl  (4): start_lat, start_lng, end_lat, end_lng
dttm (2): started_at, ended_at

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
Rows: 823488 Columns: 13                                                                    
── Column specification ─────────────────────────────────
Delimiter: ","
chr  (7): ride_id, rideable_type, start_station_name,...
dbl  (4): start_lat, start_lng, end_lat, end_lng
dttm (2): started_at, ended_at

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

# Process

## Data ****manipulation and cleaning****

### Convert the inconsistent ones to char datatype.

## Data ****manipulation and cleaning****

#GLimpse and Skim the dataset
> combined_trip <- mutate(combined_trip,start_station_id = as.character(start_station_id), end_station_id = as.character(end_station_id) )
> combined_trip <- mutate(combined_trip,start_station_name = as.character(start_station_name), end_station_name = as.character(end_station_name) )
> combined_trip <- remove_empty(combined_trip,which = c("rows"))
> combined_trip <- remove_empty(combined_trip,which = c("cols"))
> dim(combined_trip)
[1] 5901463      13

> glimpse(combined_trip)
Rows: 5,901,463
Columns: 13
$ ride_id            <chr> "99103BB87CC6C1BB", "EAFCCCF…
$ rideable_type      <chr> "electric_bike", "electric_b…
$ started_at         <dttm> 2021-08-10 17:15:49, 2021-0…
$ ended_at           <dttm> 2021-08-10 17:22:44, 2021-0…
$ start_station_name <chr> NA, NA, NA, NA, NA, NA, NA, …
$ start_station_id   <chr> NA, NA, NA, NA, NA, NA, NA, …
$ end_station_name   <chr> NA, NA, NA, NA, NA, NA, NA, …
$ end_station_id     <chr> NA, NA, NA, NA, NA, NA, NA, …
$ start_lat          <dbl> 41.77000, 41.77000, 41.95000…
$ start_lng          <dbl> -87.68000, -87.68000, -87.65…
$ end_lat            <dbl> 41.77000, 41.77000, 41.97000…
$ end_lng            <dbl> -87.68000, -87.63000, -87.66…
$ member_casual      <chr> "member", "member", "member"…

> skim_without_charts(combined_trip)
── Data Summary ────────────────────────
                           Values       
Name                       combined_trip
Number of rows             5901463      
Number of columns          13           
_______________________                 
Column type frequency:                  
  character                7            
  numeric                  4            
  POSIXct                  2            
________________________                
Group variables            None         

── Variable type: character ─────────────────────────────
  skim_variable      n_missing complete_rate min max
1 ride_id                    0         1      16  16
2 rideable_type              0         1      11  13
3 start_station_name    860786         0.854   3  64
4 start_station_id      860784         0.854   3  44
5 end_station_name      919896         0.844   9  64
6 end_station_id        919896         0.844   3  44
7 member_casual              0         1       6   6
  empty n_unique whitespace
1     0  5901463          0
2     0        3          0
3     0     1381          0
4     0     1226          0
5     0     1396          0
6     0     1236          0
7     0        2          0

── Variable type: numeric ───────────────────────────────
  skim_variable n_missing complete_rate  mean     sd
1 start_lat             0         1      41.9 0.0473
2 start_lng             0         1     -87.6 0.0309
3 end_lat            5590         0.999  41.9 0.0473
4 end_lng            5590         0.999 -87.6 0.0306
     p0   p25   p50   p75  p100
1  41.6  41.9  41.9  41.9  45.6
2 -87.8 -87.7 -87.6 -87.6 -73.8
3  41.4  41.9  41.9  41.9  42.4
4 -89.0 -87.7 -87.6 -87.6 -87.5

── Variable type: POSIXct ───────────────────────────────
  skim_variable n_missing complete_rate
1 started_at            0             1
2 ended_at              0             1
  min                 max                
1 2021-08-01 00:00:04 2022-07-31 23:59:58
2 2021-08-01 00:03:11 2022-08-04 13:53:01
  median              n_unique
1 2022-02-14 14:10:08  4923992
2 2022-02-14 14:20:23  4928247

> summary(combined_trip)
   ride_id          rideable_type     
 Length:5901463     Length:5901463    
 Class :character   Class :character  
 Mode  :character   Mode  :character  
                                      
                                      
                                      
                                      
   started_at                    
 Min.   :2021-08-01 00:00:04.00  
 1st Qu.:2021-09-27 12:35:12.50  
 Median :2022-02-14 14:10:08.00  
 Mean   :2022-01-31 21:50:42.24  
 3rd Qu.:2022-06-05 15:29:40.50  
 Max.   :2022-07-31 23:59:58.00  
                                 
    ended_at                      start_station_name
 Min.   :2021-08-01 00:03:11.00   Length:5901463    
 1st Qu.:2021-09-27 12:54:02.50   Class :character  
 Median :2022-02-14 14:20:23.00   Mode  :character  
 Mean   :2022-01-31 22:10:35.61                     
 3rd Qu.:2022-06-05 15:54:48.00                     
 Max.   :2022-08-04 13:53:01.00                     
                                                    
 start_station_id   end_station_name  
 Length:5901463     Length:5901463    
 Class :character   Class :character  
 Mode  :character   Mode  :character  
                                      
                                      
                                      
                                      
 end_station_id       start_lat       start_lng     
 Length:5901463     Min.   :41.64   Min.   :-87.84  
 Class :character   1st Qu.:41.88   1st Qu.:-87.66  
 Mode  :character   Median :41.90   Median :-87.64  
                    Mean   :41.90   Mean   :-87.65  
                    3rd Qu.:41.93   3rd Qu.:-87.63  
                    Max.   :45.64   Max.   :-73.80  
                                                    
    end_lat         end_lng       member_casual     
 Min.   :41.39   Min.   :-88.97   Length:5901463    
 1st Qu.:41.88   1st Qu.:-87.66   Class :character  
 Median :41.90   Median :-87.64   Mode  :character  
 Mean   :41.90   Mean   :-87.65                     
 3rd Qu.:41.93   3rd Qu.:-87.63                     
 Max.   :42.37   Max.   :-87.50                     
 NA's   :5590    NA's   :5590

> combined_trip %>%
+   count(end_station_name)
# A tibble: 1,397 × 2
   end_station_name                      n
   <chr>                             <int>
 1 10101 S Stony Island Ave              2
 2 111th St - Morgan Park Metra          5
 3 2112 W Peterson Ave                1131
 4 532 E 43rd St                        27
 5 63rd & Western Ave - north corner     5
 6 63rd & Western Ave - south corner     4
 7 63rd St Beach                      1451
 8 83rd St (Avalon Park) Metra           3
 9 900 W Harrison St                 10049
10 Abbott Park                          19
# … with 1,387 more rows
# ℹ Use `print(n = ...)` to see more rows

**Delete NA values in entire data frame.**

#Delete NA
> omt_combined_trip <- na.omit(combined_trip)
> skim_without_charts(combined_trip)
── Data Summary ────────────────────────
                           Values       
Name                       combined_trip
Number of rows             5901463      
Number of columns          13           
_______________________                 
Column type frequency:                  
  character                7            
  numeric                  4            
  POSIXct                  2            
________________________                
Group variables            None         

── Variable type: character ─────────────────────────────
  skim_variable      n_missing complete_rate min max
1 ride_id                    0         1      16  16
2 rideable_type              0         1      11  13
3 start_station_name    860786         0.854   3  64
4 start_station_id      860784         0.854   3  44
5 end_station_name      919896         0.844   9  64
6 end_station_id        919896         0.844   3  44
7 member_casual              0         1       6   6
  empty n_unique whitespace
1     0  5901463          0
2     0        3          0
3     0     1381          0
4     0     1226          0
5     0     1396          0
6     0     1236          0
7     0        2          0

── Variable type: numeric ───────────────────────────────
  skim_variable n_missing complete_rate  mean     sd
1 start_lat             0         1      41.9 0.0473
2 start_lng             0         1     -87.6 0.0309
3 end_lat            5590         0.999  41.9 0.0473
4 end_lng            5590         0.999 -87.6 0.0306
     p0   p25   p50   p75  p100
1  41.6  41.9  41.9  41.9  45.6
2 -87.8 -87.7 -87.6 -87.6 -73.8
3  41.4  41.9  41.9  41.9  42.4
4 -89.0 -87.7 -87.6 -87.6 -87.5

── Variable type: POSIXct ───────────────────────────────
  skim_variable n_missing complete_rate
1 started_at            0             1
2 ended_at              0             1
  min                 max                
1 2021-08-01 00:00:04 2022-07-31 23:59:58
2 2021-08-01 00:03:11 2022-08-04 13:53:01
  median              n_unique
1 2022-02-14 14:10:08  4923992
2 2022-02-14 14:20:23  4928247

summary(omt_combined_trip)
   ride_id          rideable_type     
 Length:4629230     Length:4629230    
 Class :character   Class :character  
 Mode  :character   Mode  :character  
                                      
                                      
                                      
   started_at                    
 Min.   :2021-08-01 00:00:04.00  
 1st Qu.:2021-09-24 08:17:45.75  
 Median :2022-02-11 17:14:55.00  
 Mean   :2022-01-30 14:23:23.00  
 3rd Qu.:2022-06-06 01:10:14.00  
 Max.   :2022-07-31 23:59:29.00  
    ended_at                      start_station_name
 Min.   :2021-08-01 00:03:30.00   Length:4629230    
 1st Qu.:2021-09-24 08:30:59.25   Class :character  
 Median :2022-02-11 17:25:54.50   Mode  :character  
 Mean   :2022-01-30 14:41:53.27                     
 3rd Qu.:2022-06-06 01:48:22.50                     
 Max.   :2022-08-01 13:26:03.00                     
 start_station_id   end_station_name  
 Length:4629230     Length:4629230    
 Class :character   Class :character  
 Mode  :character   Mode  :character  
                                      
                                      
                                      
 end_station_id       start_lat       start_lng     
 Length:4629230     Min.   :41.65   Min.   :-87.83  
 Class :character   1st Qu.:41.88   1st Qu.:-87.66  
 Mode  :character   Median :41.90   Median :-87.64  
                    Mean   :41.90   Mean   :-87.64  
                    3rd Qu.:41.93   3rd Qu.:-87.63  
                    Max.   :45.64   Max.   :-73.80  
    end_lat         end_lng       member_casual     
 Min.   :41.65   Min.   :-87.83   Length:4629230    
 1st Qu.:41.88   1st Qu.:-87.66   Class :character  
 Median :41.90   Median :-87.64   Mode  :character  
 Mean   :41.90   Mean   :-87.64                     
 3rd Qu.:41.93   3rd Qu.:-87.63                     
 Max.   :42.17   Max.   :-87.53                     
> glimpse(omt_combined_trip)
Rows: 4,629,230
Columns: 13
$ ride_id            <chr> "DD06751C6019D865", "79973DC…
$ rideable_type      <chr> "classic_bike", "classic_bik…
$ started_at         <dttm> 2021-08-08 17:21:26, 2021-0…
$ ended_at           <dttm> 2021-08-08 17:25:37, 2021-0…
$ start_station_name <chr> "Desplaines St & Kinzie St",…
$ start_station_id   <chr> "TA1306000003", "TA130900000…
$ end_station_name   <chr> "Kingsbury St & Kinzie St", …
$ end_station_id     <chr> "KA1503000043", "13042", "13…
$ start_lat          <dbl> 41.88872, 41.91808, 41.87773…
$ start_lng          <dbl> -87.64445, -87.64375, -87.65…
$ end_lat            <dbl> 41.88918, 41.90096, 41.87773…
$ end_lng            <dbl> -87.63851, -87.62378, -87.65…
$ member_casual      <chr> "member", "member", "member"…

#check NA
> sapply(omt_combined_trip, function(x)sum(is.na(x)))
           ride_id      rideable_type         started_at 
                 0                  0                  0 
          ended_at start_station_name   start_station_id 
                 0                  0                  0 
  end_station_name     end_station_id          start_lat 
                 0                  0                  0 
         start_lng            end_lat            end_lng 
                 0                  0                  0 
     member_casual 
                 0

**Now data is partially clean ,no NA or missing value, but it maybe contain duplicates, unsuitable data**

# Removing Duplicates
> omt_combined_trip %>%
+   distinct(ride_id, .keep_all = TRUE)
# A tibble: 4,629,230 × 13
   ride_id          rideable_type started_at         
   <chr>            <chr>         <dttm>             
 1 DD06751C6019D865 classic_bike  2021-08-08 17:21:26
 2 79973DC3B232048F classic_bike  2021-08-27 08:53:52
 3 0249AD4B258806AD classic_bike  2021-08-08 12:59:18
 4 F41EB054E44ACFDA classic_bike  2021-08-12 16:52:09
 5 B149E6C71A1C3B14 classic_bike  2021-08-23 15:33:04
 6 C41829CD6CC5A8B6 classic_bike  2021-08-23 10:11:09
 7 C3C88F6EE5345736 electric_bike 2021-08-28 23:09:44
 8 987AF38D6208B7E1 classic_bike  2021-08-20 22:38:08
 9 08B43209BB075653 electric_bike 2021-08-09 18:32:40
10 6882EBAFAABDBE2D classic_bike  2021-08-05 13:22:07
# … with 4,629,220 more rows, and 10 more variables:
#   ended_at <dttm>, start_station_name <chr>,
#   start_station_id <chr>, end_station_name <chr>,
#   end_station_id <chr>, start_lat <dbl>,
#   start_lng <dbl>, end_lat <dbl>, end_lng <dbl>,
#   member_casual <chr>

#changing the format of started_at and ended_at to date_time
> omt_combined_trip$started_at <- as.POSIXct(omt_combined_trip$started_at,"%Y-%m-%d %H:%M:%S")
> omt_combined_trip$ended_at <- as.POSIXct(omt_combined_trip$ended_at,"%Y-%m-%d %H:%M:%S")
> glimpse(omt_combined_trip)
Rows: 4,629,230
Columns: 13
$ ride_id            <chr> "DD06751C6019D865", "79973DC3B232048F", "0249AD4B258806AD", "F41EB054E44ACF…
$ rideable_type      <chr> "classic_bike", "classic_bike", "classic_bike", "classic_bike", "classic_bi…
$ started_at         <dttm> 2021-08-08 17:21:26, 2021-08-27 08:53:52, 2021-08-08 12:59:18, 2021-08-12 …
$ ended_at           <dttm> 2021-08-08 17:25:37, 2021-08-27 09:18:29, 2021-08-08 12:59:55, 2021-08-12 …
$ start_station_name <chr> "Desplaines St & Kinzie St", "Larrabee St & Armitage Ave", "Aberdeen St & J…
$ start_station_id   <chr> "TA1306000003", "TA1309000006", "13157", "13042", "13042", "13157", "TA1309…
$ end_station_name   <chr> "Kingsbury St & Kinzie St", "Michigan Ave & Oak St", "Aberdeen St & Jackson…
$ end_station_id     <chr> "KA1503000043", "13042", "13157", "13042", "13042", "13157", "TA1309000006"…
$ start_lat          <dbl> 41.88872, 41.91808, 41.87773, 41.90096, 41.90096, 41.87773, 41.91814, 41.89…
$ start_lng          <dbl> -87.64445, -87.64375, -87.65479, -87.62378, -87.62378, -87.65479, -87.64373…
$ end_lat            <dbl> 41.88918, 41.90096, 41.87773, 41.90096, 41.90096, 41.87773, 41.91813, 41.89…
$ end_lng            <dbl> -87.63851, -87.62378, -87.65479, -87.62378, -87.62378, -87.65479, -87.64374…
$ member_casual      <chr> "member", "member", "member", "casual", "casual", "casual", "casual", "casu…

**Now we have clean data to manipulation two columns to add : Time spent during each trip (column name is ride_length), extract the date (column name is year_month)**
#add a new colume as ride_length
> clean_trip <- omt_combined_trip
> start_time <- format(as.POSIXct(clean_trip$started_at),format= "%H:%M:%S")
> end_time <- format(as.POSIXct(clean_trip$ended_at),format= "%H:%M:%S")
> end_time <- format(as.POSIXct(clean_trip$ended_at),format= "%H:%M:%S")
> class(end_time)
[1] "character"
> class(start_time)
[1] "character"
> head(start_time)
[1] "17:21:26" "08:53:52" "12:59:18" "16:52:09" "15:33:04" "10:11:09"

> start_time <- as.POSIXct(start_time,format="%H:%M:%S")
> end_time <- as.POSIXct(end_time,format="%H:%M:%S")
> class(start_time)
[1] "POSIXct" "POSIXt"

> clean_trip<- mutate(clean_trip,ride_length=as.double(difftime(end_time,start_time)/60)) 
> head(clean_trip$ride_length)
[1]  4.1833333 24.6166667  0.6166667  4.7000000 35.9333333 40.0333333

> #checks if any row in the column ride_length has negative value if its have then drop it
> nrow(subset(clean_trip,ride_length < 0))
[1] 26110

> clean_trip <- subset(clean_trip,ride_length >=0)
> nrow(subset(clean_trip,ride_length < 0))
[1] 0



#add a new colume as ride_length
> clean_trip <- omt_combined_trip
> start_time <- format(as.POSIXct(clean_trip$started_at),format= "%H:%M:%S")
> end_time <- format(as.POSIXct(clean_trip$ended_at),format= "%H:%M:%S")
> end_time <- format(as.POSIXct(clean_trip$ended_at),format= "%H:%M:%S")
> class(end_time)
[1] "character"
> class(start_time)
[1] "character"
> head(start_time)
[1] "17:21:26" "08:53:52" "12:59:18" "16:52:09" "15:33:04" "10:11:09"

> start_time <- as.POSIXct(start_time,format="%H:%M:%S")
> end_time <- as.POSIXct(end_time,format="%H:%M:%S")
> class(start_time)
[1] "POSIXct" "POSIXt"

> clean_trip<- mutate(clean_trip,ride_length=as.double(difftime(end_time,start_time)/60)) 
> head(clean_trip$ride_length)
[1]  4.1833333 24.6166667  0.6166667  4.7000000 35.9333333 40.0333333

> #checks if any row in the column ride_length has negative value if its have then drop it
> nrow(subset(clean_trip,ride_length < 0))
[1] 26110

> clean_trip <- subset(clean_trip,ride_length >=0)
> nrow(subset(clean_trip,ride_length < 0))
[1] 0


**NOW DATA IS CLEANED**

# **Analyze & Share Data**

This report will show the trip and time different between members and casual riders.

## **Trip by User Type**

member <- data.frame(m=clean_trip$member_casual)
PieChart(m, hole = 0, values = "%",data = member,
         fill = c("lightblue", "pink"), main = "Trip by User Type",radius = 0.8)

>>> Suggestions
PieChart(m, hole=0)  # traditional pie chart
PieChart(m, values="%")  # display %'s on the chart
PieChart(m)  # bar chart
Plot(m)  # bubble plot
Plot(m, values="count")  # lollipop plot 

--- m --- 

                casual   member         Total 
Frequencies:   1930786  2672334       4603120 
Proportions:     0.419    0.581         1.000 

Chi-squared test of null hypothesis of equal probabilities 
  Chisq = 119461.026, df = 1, p-value = 0.000

**Hours cycled by per user trip**
trip_time <- clean_trip %>%
  group_by(member_casual) %>%
  summarize(time=sum(ride_length,na.rm = TRUE))

ggplot(trip_time,aes(x=member_casual,y=time))+
  geom_bar(fill="lightblue",stat = 'identity')+
  labs(title = "Minutes cycled by user type",
       subtite="period from aug2021 to jul2022",
       x="User Type",y="Minutes Cycled") +
scale_y_continuous(labels = label_number(suffix = " M", scale = 1e-6)) +
  geom_label(aes(label=round(time,2)), vjust=+2, color="black")

#average time by per trip user
> trip_time_avg <- clean_trip %>%
+   group_by(member_casual) %>%
+   summarize(avg_time=mean(ride_length,.keep_all = TRUE))
> print(trip_time_avg)
# A tibble: 2 × 2
  member_casual avg_time
  <chr>            <dbl>
1 casual            24.3
2 member            12.4

**Bike preference by user type**
> trip_bike_preference <- clean_trip %>%
+   group_by(member_casual,rideable_type) %>%
+   summarize(count_of=n())
`summarise()` has grouped output by 'member_casual'. You can
override using the `.groups` argument.
> print(trip_bike_preference)
# A tibble: 5 × 3
# Groups:   member_casual [2]
  member_casual rideable_type count_of
  <chr>         <chr>            <int>
1 casual        classic_bike   1118783
2 casual        docked_bike     220713
3 casual        electric_bike   591290
4 member        classic_bike   1914777
5 member        electric_bike   757557

ggplot(trip_bike_preference,aes(x=member_casual,y=count_of,fill=rideable_type))+
  geom_bar(stat ="identity")+
  labs(
    title = "Bike Preference by user_type",
    subtitle = "duration from aug 2021 to jul 2022",
    x= "user type",
    y= 'number of users'
  )+
  scale_y_continuous(labels = label_number(suffix = "M",scale= 1e-6))+
  geom_label(aes(label=count_of), position = position_stack(vjust = .5), color="black")

**Number of rides completed by day by day user type**
> data_day<- mutate(clean_trip,start_day=weekdays(started_at)) %>%
+   group_by(start_day,member_casual) %>%
+   summarize(count_of=n())
`summarise()` has grouped output by 'start_day'. You can override using the `.groups` argument.
> print(data_day)
# A tibble: 14 × 3
# Groups:   start_day [7]
   start_day member_casual count_of
   <chr>     <chr>            <int>
 1 Friday    casual          260026
 2 Friday    member          363562
 3 Monday    casual          227811
 4 Monday    member          376906
 5 Saturday  casual          417085
 6 Saturday  member          353587
 7 Sunday    casual          378076
 8 Sunday    member          327713
 9 Thursday  casual          235402
10 Thursday  member          413398
11 Tuesday   casual          203177
12 Tuesday   member          419276
13 Wednesday casual          209209
14 Wednesday member          417892

day <- c("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday")
data_day$start_day <- factor(data_day$start_day,levels = day)

#bar chart (√）
ggplot(data_day,aes(x=start_day,y=count_of,fill=member_casual)) +
  geom_bar(position ='dodge',stat='identity')+
  labs(
    title = "Number of rides completed by day by user type",
    subtitle = "For the period between Aug 2021 and Jul 2022",
    x = "Day",
    y = "Number of rides completed",
  ) +
scale_y_continuous(labels = label_number(suffix = " K", scale = 1e-3))


**year_month vs riding trend**

#Monthly Usage
#Number of rides completed by month by month user type
data_month <- clean_trip %>% 
  group_by(year_month,member_casual) %>% 
  summarise(count_of = n())
print(data_month)
#line chart
month <- c("21 - Aug","21 - Sep","21 - Oct","21 - Nov","21 - Dec","22 - Jan","22 - Feb","22 - Mar","22 - Apr","22 - May","22 - Jun","22 - Jul")
data_month$year_month <- factor(data_month$year_month,levels = month)

ggplot(data_month,aes(x=year_month,y=count_of,group=member_casual,color=member_casual))+
  geom_line(stat="identity")+
  labs(title = "Monthly usage",
       subtitle = "For the period between aug 2021 and jul 2022",
       x = "Month",
       y = "Number of rides completed")+
  scale_y_continuous(labels = label_number(suffix = " K", scale = 1e-3))


**Times spent  by user type by day**
#Times spent  by user type by day

data_day_length <- mutate(clean_trip,start_day=weekdays(started_at)) %>% 
  group_by(start_day,member_casual) %>% 
  summarise(time_day = sum(ride_length))

print(data_day_length)

day <- c("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday")
data_day_length$start_day <- factor(data_day_length$start_day,levels = day)

ggplot(data_day_length,aes(x=start_day,y= time_day,fill=member_casual))+
  geom_bar(position ='dodge',stat="identity") +
  labs(
    title = "Times spent  by user type by day",,
    subtitle = "For the period between Jun 2021 and Jul 2022",
    x = "Day",
    y = "Time_spent"
  ) +
  scale_y_continuous(labels = label_number(suffix = " M", scale = 1e-6))


**Times spent  by user type by month**

#Times spent  by user type by month
data_month_length <- clean_trip %>% 
  group_by(year_month,member_casual) %>% 
  summarise(time_month = sum(ride_length))

print(data_month_length)
month <- c("21 - Aug","21 - Sep","21 - Oct","21 - Nov","21 - Dec","22 - Jan","22 - Feb","22 - Mar","22 - Apr","22 - May","22 - Jun","22 - Jul")
data_month_length$year_month <- factor(data_month_length$year_month,levels = month)

ggplot(data_month_length,aes(x=year_month,y=time_month,group=member_casual,color=member_casual))+
  geom_line(stat="identity")+
  labs(title = "Times spent  by user type by month",
       subtitle = "For the period between aug 2021 and jul 2022",
       x = "Month",
       y = "Time_spent(Hours)")+
  scale_y_continuous(labels = label_number(suffix = " M", scale = 1e-6))
  
**Top 10 start station and end station by user type**
#Top 10 start_station by user type
data_staion <- clean_trip  %>% 
  group_by(member_casual,start_station_name) %>% 
  summarise(count_of = n()) %>%
  arrange(desc(count_of))
print(data_staion)

# A tibble: 2,415 × 3
# Groups:   member_casual [2]
   member_casual start_station_name                 count_of
   <chr>         <chr>                                 <int>
 1 casual        Streeter Dr & Grand Ave               59885
 2 casual        DuSable Lake Shore Dr & Monroe St     31361
 3 casual        Millennium Park                       27239
 4 casual        Michigan Ave & Oak St                 26521
 5 casual        DuSable Lake Shore Dr & North Blvd    25765
 6 member        Kingsbury St & Kinzie St              25193
 7 member        Clark St & Elm St                     22342
 8 member        Wells St & Concord Ln                 22152
 9 casual        Shedd Aquarium                        20763
10 member        Wells St & Elm St                     19600
# … with 2,405 more rows
# ℹ Use `print(n = ...)` to see more rows

#now filter it by member and casual
data_staion1 <- data_staion %>% 
  filter(member_casual=="casual") %>% 
  rename(num_of_trips=count_of) %>% 
  slice(1:10)
print(data_staion1)

# A tibble: 10 × 3
# Groups:   member_casual [1]
   member_casual start_station_name                 num_of_trips
   <chr>         <chr>                                     <int>
 1 casual        Streeter Dr & Grand Ave                   59885
 2 casual        DuSable Lake Shore Dr & Monroe St         31361
 3 casual        Millennium Park                           27239
 4 casual        Michigan Ave & Oak St                     26521
 5 casual        DuSable Lake Shore Dr & North Blvd        25765
 6 casual        Shedd Aquarium                            20763
 7 casual        Theater on the Lake                       19351
 8 casual        Wells St & Concord Ln                     17506
 9 casual        Clark St & Lincoln Ave                    14473
10 casual        Wells St & Elm St                         14327

ggplot(data_staion1,aes(x=(start_station_name,-num_of_trips),y=num_of_trips,str_wrap(x,width = 20)))+
   geom_bar(fill="pink",stat="identity") +
   labs(
     title = "Top 10 start_station by casual riders",
     subtitle = "For the period between Aug 2021 and Jul 2022",
     x = "Stations",
     y = "Num_of_trips"
   ) +
   scale_y_continuous(labels = label_number(suffix = " K", scale = 1e-3))+
   scale_x_discrete(labels=function(x)str_wrap(x,width = 15))
   
data_staion2 <- data_staion %>% 
  filter(member_casual=="member") %>% 
  rename(num_of_trips=count_of) %>% 
  slice(1:10)
print(data_staion2)
# A tibble: 10 × 3
# Groups:   member_casual [1]
   member_casual start_station_name           num_of_trips
   <chr>         <chr>                               <int>
 1 member        Kingsbury St & Kinzie St            25193
 2 member        Clark St & Elm St                   22342
 3 member        Wells St & Concord Ln               22152
 4 member        Wells St & Elm St                   19600
 5 member        Clinton St & Madison St             18821
 6 member        Clinton St & Washington Blvd        18695
 7 member        Ellis Ave & 60th St                 17737
 8 member        Dearborn St & Erie St               17580
 9 member        Wells St & Huron St                 17414
10 member        St. Clair St & Erie St              17295

ggplot(data_staion2,aes(x=reorder(start_station_name,-num_of_trips),y=num_of_trips,str_wrap(x,width = 20)))+
   geom_bar(fill="lightblue",stat="identity") +
   labs(
     title = "Top 10 start_station by members",
     subtitle = "For the period between Aug 2021 and Jul 2022",
     x = "Stations",
     y = "Num_of_trips"
   ) +
   scale_y_continuous(labels = label_number(suffix = " K", scale = 1e-3))+
   scale_x_discrete(labels=function(x)str_wrap(x,width = 15))
   
**Top 10 end_station by user type**

#Top 10 end_station by user type

end_station<- clean_trip %>% 
  group_by(member_casual,end_station_name) %>% 
  summarise(count_of = n()) %>%
  arrange(desc(count_of))
print(end_station)

# A tibble: 2,452 × 3
# Groups:   member_casual [2]
   member_casual end_station_name                   count_of
   <chr>         <chr>                                 <int>
 1 casual        Streeter Dr & Grand Ave               62821
 2 casual        DuSable Lake Shore Dr & North Blvd    30023
 3 casual        DuSable Lake Shore Dr & Monroe St     29529
 4 casual        Millennium Park                       28810
 5 casual        Michigan Ave & Oak St                 28302
 6 member        Kingsbury St & Kinzie St              24956
 7 member        Wells St & Concord Ln                 22723
 8 member        Clark St & Elm St                     22553
 9 casual        Theater on the Lake                   20801
10 casual        Shedd Aquarium                        19965
# … with 2,442 more rows
# ℹ Use `print(n = ...)` to see more rows

#now filter it by member and casual
> end_station1 <- end_station %>% 
+   filter(member_casual=="casual") %>% 
+   rename(num_of_trips=count_of) %>% 
+   slice(1:10)
> print(end_station1)
# A tibble: 10 × 3
# Groups:   member_casual [1]
   member_casual end_station_name                   num_of_trips
   <chr>         <chr>                                     <int>
 1 casual        Streeter Dr & Grand Ave                   62821
 2 casual        DuSable Lake Shore Dr & North Blvd        30023
 3 casual        DuSable Lake Shore Dr & Monroe St         29529
 4 casual        Millennium Park                           28810
 5 casual        Michigan Ave & Oak St                     28302
 6 casual        Theater on the Lake                       20801
 7 casual        Shedd Aquarium                            19965
 8 casual        Wells St & Concord Ln                     17021
 9 casual        Clark St & Lincoln Ave                    14641
10 casual        Clark St & Armitage Ave                   14563

end_station2 <- end_station %>% 
  filter(member_casual=="member") %>% 
  rename(num_of_trips=count_of) %>% 
  slice(1:10)
print(end_station2)
# A tibble: 10 × 3
# Groups:   member_casual [1]
   member_casual end_station_name                   num_of_trips
   <chr>         <chr>                                     <int>
 1 member        Kingsbury St & Kinzie St                  24956
 2 member        Wells St & Concord Ln                     22723
 3 member        Clark St & Elm St                         22553
 4 member        Wells St & Elm St                         19648
 5 member        Clinton St & Washington Blvd              19484
 6 member        Clinton St & Madison St                   19225
 7 member        University Ave & 57th St                  18010
 8 member        Dearborn St & Erie St                     17888
 9 member        DuSable Lake Shore Dr & North Blvd        17541
10 member        Broadway & Barry Ave                      17513


