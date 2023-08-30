-- dataset from https://www.kaggle.com/datasets/rajyellow46/wine-quality

-- create database
CREATE DATABASE `wine_database`; 
USE `wine_database`;

SET NAMES utf8 ;
SET character_set_client = utf8mb4 ;

-- create table to load data into
CREATE TABLE `wine_data` (
	`type` varchar(10),
    `fixed_acidity` DEC(2, 1),
    `volatile_acidity` DEC(3, 2),
    `citric_acid` DEC(3,2),
    `residual_sugar` DEC(6,3),
    `chlorides` DEC(5,4),
    `free_sulfur_dioxide` INT,
    `total_wine_datasulfur_dioxide` INT,
    `density` DEC(6, 5),
    `pH` DEC(4,3),
    `sulphates` DEC(3,2),
    `alcohol` DEC (5,2),
    `quality` INT
);
 
 
 -- __________________________ USE TABLE DATA IMPORT WIZARD __________________________
 
 
-- create tables seperating wine by red and white and then good and bad
CREATE TABLE red_wine_data AS 
SELECT *
FROM wine_data
WHERE type = 'red';

CREATE TABLE white_wine_data AS 
SELECT *
FROM wine_data
WHERE type = 'white';
    
CREATE TABLE good_red_wine AS 
SELECT *
FROM red_wine_data
WHERE quality >= 7;    

CREATE TABLE good_white_wine AS 
SELECT *
FROM white_wine_data
WHERE quality >= 7;   

CREATE TABLE bad_red_wine AS 
SELECT *
FROM red_wine_data
WHERE quality < 7;    

CREATE TABLE bad_white_wine AS 
SELECT *
FROM white_wine_data
WHERE quality < 7;  
    
-- drop older tables
DROP TABLE white_wine_data;
DROP TABLE red_wine_data;
DROP TABLE wine_data;
 
-- create table table to show different alcohol content levels
CREATE TABLE `alcohol_content` (
	`type` varchar(20),
    `low_range` DEC(3,1),
    `high_range` DEC(3,1),
    PRIMARY KEY (`type`)
);
    
INSERT INTO `alcohol_content` VALUES ('low', 0, 10);
INSERT INTO `alcohol_content` VALUES ('medium-low', 10, 11.5);
INSERT INTO `alcohol_content` VALUES ('medium', 11.5, 13.5);
INSERT INTO `alcohol_content` VALUES ('medium-high', 13.5, 15);
INSERT INTO `alcohol_content` VALUES ('high', 15, 99);
     
-- add id to each table as a primary key
ALTER TABLE `good_white_wine` ADD `wine_id` INT NOT NULL AUTO_INCREMENT primary key;
ALTER TABLE `bad_white_wine` ADD `wine_id` INT NOT NULL AUTO_INCREMENT primary key;
ALTER TABLE `good_red_wine` ADD `wine_id` INT NOT NULL AUTO_INCREMENT primary key;
ALTER TABLE `bad_red_wine` ADD `wine_id` INT NOT NULL AUTO_INCREMENT primary key;

-- create table or good white wine orders, primary key is order id and foreign key connects to good_white_wine's wine_id
CREATE TABLE `good_white_wine_orders` (
	`order_id` INT NOT NULL AUTO_INCREMENT,
    `customer` varchar(30),
    `wine_id` INT NOT NULL,
    PRIMARY KEY (`order_id`),
    KEY `fk_wine_id_idx` (`wine_id`),
    CONSTRAINT `fk_wine_id` FOREIGN KEY (`wine_id`) REFERENCES `good_white_wine` (`wine_id`) ON UPDATE CASCADE
);

INSERT INTO `good_white_wine_orders` VALUES (1, "John Smith", 1);
INSERT INTO `good_white_wine_orders` VALUES (2, "Jane Doe", 5);
INSERT INTO `good_white_wine_orders` VALUES (3, "Mary Sue", 3);
INSERT INTO `good_white_wine_orders` VALUES (4, "Alex Morris", 5);
INSERT INTO `good_white_wine_orders` VALUES (5, "Sam Jones", 999);
INSERT INTO `good_white_wine_orders` VALUES (6, "Peter Park", 1000);
INSERT INTO `good_white_wine_orders` VALUES (7, "Isabelle Jones", 500);
INSERT INTO `good_white_wine_orders` VALUES (8, "Katie Poissant", 3);
INSERT INTO `good_white_wine_orders` VALUES (9, "Taylor Swift", 10);
INSERT INTO `good_white_wine_orders` VALUES (10, "Harry Styles", 1000);
INSERT INTO `good_white_wine_orders` VALUES (11, "John Smith", 20);
INSERT INTO `good_white_wine_orders` VALUES (12, "Jane Doe", 18);
INSERT INTO `good_white_wine_orders` VALUES (13, "Mary Sue", 12);
INSERT INTO `good_white_wine_orders` VALUES (14, "Alex Morris", 12);
INSERT INTO `good_white_wine_orders` VALUES (15, "Sam Jones", 3);
INSERT INTO `good_white_wine_orders` VALUES (16, "Peter Park", 6);
INSERT INTO `good_white_wine_orders` VALUES (17, "Isabelle Jones", 9);
INSERT INTO `good_white_wine_orders` VALUES (18, "Katie Poissant", 8);
INSERT INTO `good_white_wine_orders` VALUES (19, "Taylor Swift", 9);
INSERT INTO `good_white_wine_orders` VALUES (20, "Harry Styles", 1);
INSERT INTO `good_white_wine_orders` VALUES (21, "John Smith", 1);
INSERT INTO `good_white_wine_orders` VALUES (22, "Jane Doe", 17);
INSERT INTO `good_white_wine_orders` VALUES (23, "Mary Sue", 16);
INSERT INTO `good_white_wine_orders` VALUES (24, "Alex Morris", 16);
INSERT INTO `good_white_wine_orders` VALUES (25, "Sam Jones", 16);
INSERT INTO `good_white_wine_orders` VALUES (26, "Peter Park", 10);
INSERT INTO `good_white_wine_orders` VALUES (27, "Isabelle Jones", 14);
INSERT INTO `good_white_wine_orders` VALUES (28, "Katie Poissant", 17);
INSERT INTO `good_white_wine_orders` VALUES (29, "Taylor Swift", 16);
INSERT INTO `good_white_wine_orders` VALUES (30, "Harry Styles", 9);
INSERT INTO `good_white_wine_orders` VALUES (31, "John Smith", 4);
INSERT INTO `good_white_wine_orders` VALUES (32, "Jane Doe", 7);
INSERT INTO `good_white_wine_orders` VALUES (33, "Mary Sue", 20);
INSERT INTO `good_white_wine_orders` VALUES (34, "Alex Morris", 12);
INSERT INTO `good_white_wine_orders` VALUES (35, "Sam Jones", 2);
INSERT INTO `good_white_wine_orders` VALUES (36, "Peter Park", 4);
INSERT INTO `good_white_wine_orders` VALUES (37, "Isabelle Jones", 7);
INSERT INTO `good_white_wine_orders` VALUES (38, "Katie Poissant", 17);
INSERT INTO `good_white_wine_orders` VALUES (39, "Taylor Swift", 15);
INSERT INTO `good_white_wine_orders` VALUES (40, "Harry Styles", 16);






    