-- add the number of orders for each wine from the orders table
ALTER TABLE good_white_wine
ADD order_amounts int DEFAULT 0;

UPDATE good_white_wine gww
SET gww.order_amounts = (SELECT COUNT(*) 
			FROM good_white_wine_orders gwwo
			WHERE gwwo.wine_id = gww.wine_id);

-- add written out alcohol content level to good_white_wine
ALTER TABLE good_white_wine
ADD comments varchar(50);

UPDATE good_white_wine gww
SET comments = "low"
WHERE gww.alcohol < 10;

UPDATE good_white_wine gww
SET comments = "medium-low"
WHERE gww.alcohol >= 10 AND gww.alcohol < 11.5;

UPDATE good_white_wine gww
SET comments = "medium"
WHERE gww.alcohol >= 11.5 AND gww.alcohol < 13.5;

UPDATE good_white_wine gww
SET comments = "medium-high"
WHERE gww.alcohol >= 13.5 AND gww.alcohol < 15;

UPDATE good_white_wine gww
SET comments = "high"
WHERE gww.alcohol > 15;

ALTER TABLE good_white_wine
RENAME COLUMN comments TO alcohol_content;

-- calculate number of good white wines at each alcohol level and add it to table
ALTER TABLE alcohol_content
ADD number_of_wines int DEFAULT 0;

UPDATE alcohol_content ac
SET ac.number_of_wines = (SELECT COUNT(*) 
			FROM good_white_wine gww
			WHERE gww.alcohol_content = ac.type);

ALTER TABLE alcohol_content
RENAME COLUMN number_of_wines TO number_of_good_white_wines;
            
-- -------------------------------------------------------------------

-- add written out alcohol content level to bad_white_wine
ALTER TABLE bad_white_wine
ADD alcohol_content varchar(50);

UPDATE bad_white_wine bww
SET alcohol_content = "low"
WHERE bww.alcohol < 10;

UPDATE bad_white_wine bww
SET alcohol_content = "medium-low"
WHERE bww.alcohol >= 10 AND bww.alcohol < 11.5;

UPDATE bad_white_wine bww
SET alcohol_content = "medium"
WHERE bww.alcohol >= 11.5 AND bww.alcohol < 13.5;

UPDATE bad_white_wine bww
SET alcohol_content = "medium-high"
WHERE bww.alcohol >= 13.5 AND bww.alcohol < 15;

UPDATE bad_white_wine bww
SET alcohol_content = "high"
WHERE bww.alcohol > 15;

-- calculate number of bad white wines at each alcohol level and add it to table
ALTER TABLE alcohol_content
ADD number_of_bad_white_wines int DEFAULT 0;

UPDATE alcohol_content ac
SET ac.number_of_bad_white_wines = (SELECT COUNT(*) 
			FROM bad_white_wine bww
			WHERE bww.alcohol_content = ac.type);
            
-- -------------------------------------------------------------------

-- add written out alcohol content level to good_red_wine
ALTER TABLE good_red_wine
ADD alcohol_content varchar(50);

UPDATE good_red_wine grw
SET alcohol_content = "low"
WHERE grw.alcohol < 10;

UPDATE good_red_wine grw
SET alcohol_content = "medium-low"
WHERE grw.alcohol >= 10 AND grw.alcohol < 11.5;

UPDATE good_red_wine grw
SET alcohol_content = "medium"
WHERE grw.alcohol >= 11.5 AND grw.alcohol < 13.5;

UPDATE good_red_wine grw
SET alcohol_content = "medium-high"
WHERE grw.alcohol >= 13.5 AND grw.alcohol < 15;

UPDATE good_red_wine grw
SET alcohol_content = "high"
WHERE grw.alcohol > 15;

-- calculate number of good red wines at each alcohol level and add it to table
ALTER TABLE alcohol_content
ADD number_of_good_red_wines int DEFAULT 0;

UPDATE alcohol_content ac
SET ac.number_of_good_red_wines = (SELECT COUNT(*) 
			FROM good_red_wine grw
			WHERE grw.alcohol_content = ac.type);
            
-- -------------------------------------------------------------------

-- add written out alcohol content level to bad_red_wine
ALTER TABLE bad_red_wine
ADD alcohol_content varchar(50);

UPDATE bad_red_wine brw
SET alcohol_content = "low"
WHERE brw.alcohol < 10;

UPDATE bad_red_wine brw
SET alcohol_content = "medium-low"
WHERE brw.alcohol >= 10 AND brw.alcohol < 11.5;

UPDATE bad_red_wine brw
SET alcohol_content = "medium"
WHERE brw.alcohol >= 11.5 AND brw.alcohol < 13.5;

UPDATE bad_red_wine brw
SET alcohol_content = "medium-high"
WHERE brw.alcohol >= 13.5 AND brw.alcohol < 15;

UPDATE bad_red_wine brw
SET alcohol_content = "high"
WHERE brw.alcohol > 15;

-- calculate number of bad red wines at each alcohol level and add it to table
ALTER TABLE alcohol_content
ADD number_of_bad_red_wines int DEFAULT 0;

UPDATE alcohol_content ac
SET ac.number_of_bad_red_wines = (SELECT COUNT(*) 
			FROM bad_red_wine brw
			WHERE brw.alcohol_content = ac.type);

-- -------------------------------------------------------------------------

-- create a new table by joining info from good white wine orders and good white wine
CREATE TABLE good_white_wine_order_details AS
SELECT 
	order_id, 
    customer,
    gww.wine_id,
    quality,
    alcohol_content,
    fixed_acidity,
    residual_sugar,
    total_wine_datasulfur_dioxide,
    pH
FROM good_white_wine_orders gwwo
JOIN good_white_wine gww
	USING (wine_id);


-- add good or bad labels to each table to prepare for union
ALTER TABLE bad_red_wine
ADD good_or_bad varchar(4) NOT NULL DEFAULT 'bad';

ALTER TABLE good_red_wine
ADD good_or_bad varchar(4) NOT NULL DEFAULT 'good';

ALTER TABLE bad_white_wine
ADD good_or_bad varchar(4) NOT NULL DEFAULT 'bad';

ALTER TABLE good_white_wine
ADD good_or_bad varchar(4) NOT NULL DEFAULT 'good';

-- combine good and bad red wines
CREATE TABLE red_wine AS
SELECT 
	type, 
    fixed_acidity, 
    volatile_acidity, 
    citric_acid, 
    residual_sugar, 
    chlorides, 
    free_sulfur_dioxide, 
    total_wine_datasulfur_dioxide, 
    density, 
    pH, 
    sulphates, 
    alcohol, 
    quality, 
    wine_id, 
    alcohol_content, 
    good_or_bad
FROM good_red_wine
UNION
SELECT 
	type, 
    fixed_acidity, 
    volatile_acidity, 
    citric_acid, 
    residual_sugar, 
    chlorides, 
    free_sulfur_dioxide, 
    total_wine_datasulfur_dioxide, 
    density, 
    pH, 
    sulphates, 
    alcohol, 
    quality, 
    wine_id, 
    alcohol_content, 
    good_or_bad
FROM bad_red_wine;

-- match columns in good white wine
ALTER TABLE bad_white_wine
ADD order_amounts int DEFAULT 0;

-- combine good and bad white wines
CREATE TABLE white_wine AS
SELECT 
	type, 
    fixed_acidity, 
    volatile_acidity, 
    citric_acid, 
    residual_sugar, 
    chlorides, 
    free_sulfur_dioxide, 
    total_wine_datasulfur_dioxide, 
    density, 
    pH, 
    sulphates, 
    alcohol, 
    quality, 
    wine_id, 
    alcohol_content, 
    good_or_bad,
    order_amounts
FROM good_white_wine
UNION
SELECT 
	type, 
    fixed_acidity, 
    volatile_acidity, 
    citric_acid, 
    residual_sugar, 
    chlorides, 
    free_sulfur_dioxide, 
    total_wine_datasulfur_dioxide, 
    density, 
    pH, 
    sulphates, 
    alcohol, 
    quality, 
    wine_id, 
    alcohol_content, 
    good_or_bad,
    order_amounts
FROM bad_white_wine;

-- match columns in white wine
ALTER TABLE red_wine
ADD order_amounts int DEFAULT 0;

-- recreate original table, now with new columns
CREATE TABLE wine AS
SELECT 
	type, 
    fixed_acidity, 
    volatile_acidity, 
    citric_acid, 
    residual_sugar, 
    chlorides, 
    free_sulfur_dioxide, 
    total_wine_datasulfur_dioxide, 
    density, 
    pH, 
    sulphates, 
    alcohol, 
    quality, 
    wine_id, 
    alcohol_content, 
    good_or_bad,
    order_amounts
FROM white_wine
UNION
SELECT 
	type, 
    fixed_acidity, 
    volatile_acidity, 
    citric_acid, 
    residual_sugar, 
    chlorides, 
    free_sulfur_dioxide, 
    total_wine_datasulfur_dioxide, 
    density, 
    pH, 
    sulphates, 
    alcohol, 
    quality, 
    wine_id, 
    alcohol_content, 
    good_or_bad,
    order_amounts
FROM red_wine;

-- set primary keys for this table - type, good or bad, and wine id
ALTER TABLE wine
ADD CONSTRAINT PK_wine PRIMARY KEY (type, good_or_bad, wine_id);




