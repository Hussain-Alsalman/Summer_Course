###-----Helping Functions ---------####
library('here')
source(file = here('R_Code', 'help_Functions.R'))
#--------------------------------------

## Reading the data from database and using SQL commands 
library("ODB")
library("tidyverse")
## let's connect to the database 
odb <- odb.open(odbFile = here("datasets", "TT NorthWind.odb"))
df <- odb.read(odb, 'SELECT "C"."CustomerID",
               "C"."Country",
               "C"."ContactName", 
               "O"."OrderID",
               "O"."OrderDate",
               "O"."ShipVia",
               "O"."ShipName",
               "O"."ShipCity",
               "OD"."ProductID",
               "OD"."UnitPrice", 
               "OD"."Quantity", 
               "P"."ProductName", 
               "P"."CategoryID", 
               "P"."SupplierID", 
               "S"."CompanyName", 
               "S"."Country", 
               "CT"."CategoryName", 
               "CT"."Description" 
               
               FROM "Customers" "C" 
               JOIN "Orders" "O" 
               ON "C"."CustomerID" = "O"."CustomerID" 
               JOIN "Order Details" "OD"
               ON "O"."OrderID" = "OD"."OrderID" 
               JOIN "Products" "P" 
               ON "OD"."ProductID" = "P"."ProductID" 
               JOIN "Suppliers" "S" 
               ON "P"."SupplierID" = "S"."SupplierID" 
               JOIN "Categories" "CT" 
               ON "P"."CategoryID" = "CT"."CategoryID"')

names(df)[16] <- "Supplier_Country"
names(df)[2] <- "Customer_Country"
str(df)

View(head(df))
## Classify the high valued customers based on their average basket value 

df %>% group_by(CustomerID,OrderID) %>%  mutate(item_subtotal = UnitPrice * Quantity) %>% 
  summarise(sum_orders = sum(item_subtotal)) %>% group_by(CustomerID) %>% 
  summarise(avg_spend = mean(sum_orders))

df_customers <- odb.read(odb, 'SELECT * FROM "Customers"')

apply(df_customers, 2, function(x) sum(is.na(x)))
# 



# Some excercises 
# Q1 - Write a query to get Product name and quantity/unit
odb.read(odb,'
SELECT "ProductName", "QuantityPerUnit" 
    FROM "Products";
')

# Q2 - Write a query to get current Product list (Product ID and name)
odb.read(odb,'
SELECT "ProductID", "ProductName"
    FROM "Products"
    WHERE "Discontinued" = False
    ORDER BY "ProductName";
         ')
# Q3 - Write a query to get discontinued Product list (Product ID and name).
odb.read(odb,'
SELECT "ProductID", "ProductName"
    FROM "Products"
    WHERE "Discontinued" = 1 
    ORDER BY "ProductName";
         ')

# Q4 - Write a query to get most expense and least expensive Product list (name and unit price).
odb.read(odb,'
SELECT "ProductName", "UnitPrice"
FROM "Products" 
ORDER BY "UnitPrice" DESC;
         ')


# Q5 - Write a query to get Product list (id, name, unit price) where current products cost less than $20
odb.read(odb,'
SELECT "ProductID", "ProductName", "UnitPrice"
FROM "Products"
         WHERE ((("UnitPrice")<20) AND (("Discontinued")=False))
         ORDER BY "UnitPrice" DESC;
         ')

# Q6 - Write a query to get Product list (id, name, unit price) where products cost between $15 and $25.
odb.read(odb,'
SELECT "ProductName", "UnitPrice"
FROM "Products"
WHERE ((("UnitPrice")>=15 And ("UnitPrice")<=25) 
       AND (("Products"."Discontinued")=False))
ORDER BY "Products"."UnitPrice" DESC;
         ')
#Q7 - Write a query to get Product list (name, unit price) of above average price.

odb.read(odb,'SELECT DISTINCT "ProductName", "UnitPrice"
FROM "Products"
         WHERE "UnitPrice" > (SELECT avg("UnitPrice") FROM "Products")
         ORDER BY "UnitPrice";
         ')



#Q8 - Write a query to get Product list (name, unit price) of ten most expensive products
odb.read(odb,'
SELECT DISTINCT "ProductName" as "Twenty_Most_Expensive_Products", "UnitPrice"
    FROM "Products" AS "a"
        WHERE 20 >= (SELECT COUNT(DISTINCT "UnitPrice")
                     FROM "Products" AS "b"
                     WHERE "b"."UnitPrice" >= "a"."UnitPrice")
        ORDER BY "UnitPrice" desc;
         ')

# Q9 - Write a query to count current and discontinued products.
odb.read(odb,'SELECT Count("ProductName")
FROM "Products"
         GROUP BY "Discontinued";
         ')

#Q10 Write a query to get Product list (name, units on order , units in stock) of stock is less than the quantity on order
 odb.read(odb, '
SELECT "ProductName",  "UnitsOnOrder" , "UnitsInStock"
FROM "Products"
          WHERE ((("Discontinued")=False) AND (("UnitsInStock")<"UnitsOnOrder"));          
          ')



odb.close(odb = odb, write = FALSE)
