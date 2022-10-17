### PortfolioProject
Data Analyst Portfolio Project Repository

This Repository will hold all of the code and queries from the Portfolio Projects I create.

The project will mainly be focused on data projects: 


PROJECT1:BUILDING Fast QUERIES

In this project I have worked on Jypter Notebook to implement better ways of optimizing data quesries.

The goal of this guided project was to create a class that represents our inventory. 
The methods in that class will implement the queries that we want to answer about our inventory. 
I also preprocess that data to make those queries run faster.

Here are some queries that I will want to answer:

Given a laptop id, find the corresponding data.
Given an amount of money, find whether there are two laptops whose total price is that given amount.
Identify all laptops whose price falls within a given budget.

I used the laptops.csv file as our inventory. 
This CSV file was adapted from the Laptop Prices dataset on Kaggle. 
I changed the IDs and made the prices integers.

Here is a brief description of the rows:

ID: A unique identifier for the laptop.
Company: The name of the company that produces the laptop.
Product: The name of the laptop.
TypeName: The type of laptop.
Inches: The size of the screen in inches.
ScreenResolution: The resolution of the screen.
CPU: The laptop CPU.
RAM: The amount of RAM in the laptop.
Memory: The size of the hard drive.
GPU: The graphics card name.
OpSys: The name of the operating system.
Weight: The laptop weight.
Price: The price of the laptop.


Other/ More steps:

If you want to push this project further,I suggest that you think about the following queries:

Imagine that we extend our budget query to take as input a range of prices, min_price and max_price, rather than a single price. 
Write a query that finds all laptops whose price is in the given range.
Sometimes, a customer wants a laptop with some characteristics such as, for instance, 8GB or RAM and a 256GB hard drive. 
It would be interesting for those customers to provide a way to find the cheapest laptop that matches the desired characteristics. 
For simplicity, focus only on the amount of RAM and hard drive capacity. You might need to convert those values to integers rather than using strings.
In this guided project, we only explored three possible queries that we might want to do over the data. 
In general, we often have a lot of different datasets to process and queries to answer. Designing such a class for every type of data in a business and implementing specific query methods takes a lot of time.

PROJECT2: Covid Portfolio.sql
on this project I worked on analyzing Covid 19 cases on SQL.

