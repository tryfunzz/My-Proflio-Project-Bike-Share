# How Does a Bike-Share Navigate Speedy Success?
Xinmei Luo

2022-08-22

🧰 R

# **Introduction:**

I have taken this case study from the Google Data Analytics courses on Coursera. In this case , I perform data analysis for a fictional bike-share company in order to help them attract more riders.

# **Scenario:**

I am a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, my team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, my team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve the  recommendations, so they must be backed up with compelling data insights and professional data visualizations.

There are six tips of the case: Ask , Prepare,  Process, Analysis, Share and Act.

# Ask

- How do annual members and casual riders use differ ent?
- Why would casual riders buy annual membership?
- How can Cyclist u4se digital media to influence casual riders to become members?

# Prepare

## **Data source**

I will use Cyclistic’s historical trip data to analyze and identify trends.(Note: The datasets have a different name because Cyclistic is a fictional company. For the purposes of this case study,the datasets are appropriate and will enable you to answer the business questions. The data has been made available byMotivate International Inc. under this [license](https://www.divvybikes.com/data-license-agreement).) This is public data which can use to explore how different customer types are using Cyclistic bikes. But note that data-privacy issues prohibit you from using riders’ personally identifiable information.

I have used the dataset from August2021 to July2022.

The combined size of all the 12 datasets is close to 1 GB. Data cleaning in spreadsheets will slow compared to SQL or R. I chose R to clean data and analysis, visualizations in the same platform.

## **Packages & Libraries**
**Load Dataset**
**Data Import**

# Process

## Data ****manipulation and cleaning****

### Convert the inconsistent ones to char datatype.
**Delete NA values in entire data frame.**
**Now data is partially clean ,no NA or missing value, but it maybe contain duplicates, unsuitable data**
**Now we have clean data to manipulation two columns to add : Time spent during each trip (column name is ride_length), extract the date (column name is year_month)**
**NOW DATA IS CLEANED**

# **Analyze & Share Data**

This report will show the trip and time different between members and casual riders.

## **Trip by User Type**

![image](https://user-images.githubusercontent.com/113983558/199008119-4125ee04-cfdf-48b3-b642-34f52ed30d86.png)

**Hours cycled by per user trip**

![image](https://user-images.githubusercontent.com/113983558/199008162-b5429e3c-0496-4277-8637-aeb5ddcf5f04.png)

**Bike preference by user type**

![image](https://user-images.githubusercontent.com/113983558/199008227-e9e67171-ec01-48fd-8c3d-5471b31cefc5.png)

✍️**Key takeaway**: 

*Classic bike* is the most preferred bike type among both casual riders and annual members.

**Number of rides completed by day by day user type**

![image](https://user-images.githubusercontent.com/113983558/199008336-f0c74c9d-03e9-4b54-b00f-37d52c01e88e.png)

✍️**Key takeaway** : 

- Members use bike more in weekday
- Casual riders use bike more in weekend


**year_month vs riding trend**

![image](https://user-images.githubusercontent.com/113983558/199008455-f77e8c3e-80d8-45c3-b4ce-e6817dcccdc0.png)

✍️**Key takeaway** : 

- Both members and casual riders show a similar trend with more trips made in the warmer months.

**Times spent  by user type by day**

![image](https://user-images.githubusercontent.com/113983558/199008583-6414d1bd-60b1-43e6-a7e0-1838831088c7.png)

✍️**Key takeaway** : 

- Casual riders spent much more time than members on weekend.

**Times spent  by user type by month**

![image](https://user-images.githubusercontent.com/113983558/199008673-1989bf96-bf94-43aa-90b0-5bd0451b6a38.png)

✍️**Key takeaway** : 

- Both members and casual riders show a similar trend with more time made in the warmer months.
- Specially, casual riders spend more time in the warmer months than members.

**Top 10 start station and end station by user type**

![image](https://user-images.githubusercontent.com/113983558/199008761-3c142ba2-7b34-4ac3-a5ef-31f4f7f6181c.png)

![image](https://user-images.githubusercontent.com/113983558/199008779-2dcb9e79-2dd8-43fa-bb77-bf4581c5c804.png)


**Top 10 end_station by user type**

✍️**Key takeaway**: 

- Conclude the four “top stations”, we can see the casual riders’ popular stations are  located in a tourist area ,and the members’ popular stations are residential district or office area.

## Act & Recommendations

To guide the marketing campaign to convert casual riders into annual members, we now have

some data driven insights on how **casual riders and annual members use Cyclistic bikes differently**
. 

 ✍️**Key findings** :

- the demand for renting bikes rises throughout the summer and falls during the summer.
- the busiest days for casual riders are weekends ,the fact is not fit for the members.
- members prefer to take longer trips ,as casual riders prefer to take longer times.
- bicycles in tourist areas are more likely to be used by casual riders than members.

**Recommendations:**

- Develop the use of digital media during the warmer seasons .
- Develop a weekend membership plan whereby riders on the weekends ,which price is also higher than member.
- Develop a member to only rewards program based on trip length, to incentivize casual riders to sign up as members and be eligible for the rewards.
- Develop the tourism department or businesses in these stations to offer Preferential policies.



