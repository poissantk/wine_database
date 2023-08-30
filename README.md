# wine_database

Dataset from dataset from https://www.kaggle.com/datasets/rajyellow46/wine-quality

wine_database uses the above dataset to practice SQL skills such as creating tables from files and from manually adding data, adding new columns, using subqueries to update values, joining tables, and using union. Basic clauses such as SELECT, WHERE, JOIN, USING, UNION, INSERT INTO, CREATE TABLE, and ALTER TABLE were used. The end result is recreating the original table (winequality.csv) to become new-winequality.csv with added information such as the alcohol content level, whether the wine is good or bad, and the number of orders.

To recreate this, run the first few queries above the break in create-wine-databases.sql. Then, use table data import wizard to import the file winequality.csv. Next, run the rest of the queries in that file. Then, you can run the file wine-databases.sql. The final table will be called wine and can be exported to create the file new-winequality.csv/
