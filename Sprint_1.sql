-- Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.
SELECT CONCAT(FirstName, " ", LastName) AS "Full_Name", CustomerId, Country FROM Customer WHERE Country ="USA"
SELECT FirstName, LastName, CustomerId, Country FROM Customer WHERE Country ="USA"
-- Provide a query only showing the Customers from Brazil.
SELECT * FROM Customer WHERE Country="Brazil";
-- Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.
SELECT C.FirstName, C.LastName, I.InvoiceId, I.InvoiceDate, I.BillingCountry FROM Customer C INNER JOIN Invoice I ON I.CustomerId = C.CustomerId WHERE I.BillingCountry="Brazil"
SELECT CONCAT(C.FirstName, " ", C.LastName), I.InvoiceId, I.InvoiceDate, I.BillingCountry FROM Customer C INNER JOIN Invoice I ON I.CustomerId = C.CustomerId WHERE I.BillingCountry="Brazil"
-- Provide a query showing only the Employees who are Sales Agents.
SELECT * FROM Employee WHERE Title="Sales Support Agent";
-- Provide a query showing a unique/distinct list of billing countries from the Invoice table.
SELECT DISTINCT BillingCountry FROM Invoice;
-- Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.
SELECT 
E.FirstName,
E.LastName,
I.InvoiceId 
FROM Employee E 
INNER JOIN Customer C 
ON E.EmployeeId = C.SupportRepId 
INNER JOIN Invoice I 
ON  C.CustomerId = I.CustomerId;
SELECT CONCAT(E.FirstName, " ", E.LastName), I.InvoiceId FROM Employee E INNER JOIN Customer C ON E.EmployeeId = C.SupportRepId INNER JOIN Invoice I ON  C.CustomerId = I.CustomerId;
-- How many Invoices were there in 2009 and 2011?
SELECT 
COUNT(*) AS "Total_InvDate" 
FROM Invoice 
WHERE InvoiceDate 
LIKE '%2009%' OR InvoiceDate LIKE '%2011%'
-- What are the respective total sales for each of those years?
SELECT 
SUM(Total) AS  "Total" 
FROM Invoice 
WHERE InvoiceDate 
LIKE '%2009%';

SELECT 
SUM(Total) AS  "Total"
FROM Invoice 
WHERE InvoiceDate 
LIKE '%2011%';
-- Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice.
SELECT 
I.InvoiceId,
COUNT(IL.InvoiceId) AS "Total"
FROM InvoiceLine IL
INNER JOIN Invoice I
ON IL.InvoiceId = I.InvoiceId
GROUP BY I.InvoiceId
-- Provide a query that includes the purchased track name with each invoice line item.
SELECT 
T.Name,
I.InvoiceLineId
FROM InvoiceLine I
INNER JOIN Track T
ON I.TrackId = T.TrackId
ORDER BY InvoiceLineId
-- Provide a query that includes the purchased track name AND artist name with each invoice line item.
SELECT 
I.InvoiceLineId,
T.Name,
Ar.Name
FROM InvoiceLine I
INNER JOIN Track T
ON I.TrackId = T.TrackId
INNER JOIN Album A
ON T.AlbumId = A.AlbumId
INNER JOIN Artist Ar
ON A.ArtistId = Ar.ArtistId
ORDER BY InvoiceLineId
-- Provide a query that shows the # of invoices per country.
SELECT 
BillingCountry, 
COUNT (InvoiceId) AS "Total Country"
FROM Invoice 
GROUP BY BillingCountry
-- Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resultant table.
SELECT 
P.PlaylistId,
P.Name,
COUNT(PLT.PlaylistId) AS "Total"
FROM Playlist P
INNER JOIN PlaylistTrack PLT
ON P.PlaylistId = PLT.PlaylistId
GROUP BY P.PlaylistId
-- Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre.
SELECT 
T.Name,
A.Title,
MT.Name,
G.Name
FROM Track T
INNER JOIN Album A
ON T.AlbumId = A.AlbumId 
INNER JOIN MediaType MT
ON T.MediaTypeId = MT.MediaTypeId
INNER JOIN Genre G
ON T.GenreId = G.GenreId
-- Provide a query that shows all Invoices but includes the # of invoice line items.
SELECT 
I.InvoiceId,
COUNT(IL.InvoiceId) AS "Invoices"
FROM Invoice I
INNER JOIN InvoiceLine IL
ON I.InvoiceId	= IL.InvoiceId
GROUP BY I.InvoiceId
-- Provide a query that shows total sales made by each sales agent.
SELECT 
E.FirstName,
E.LastName,
COUNT(I.Total) AS "Total_Sales"
FROM Employee E
INNER JOIN Customer C
ON E.EmployeeId	= C.SupportRepId
INNER JOIN Invoice I
ON C.CustomerId = I.CustomerId
GROUP BY E.EmployeeId

SELECT 
CONCAT(E.FirstName, E.LastName) AS "Full_Name"
COUNT(I.Total) AS "Total_Sales"
FROM Employee E
INNER JOIN Customer C
ON E.EmployeeId	= C.SupportRepId
INNER JOIN Invoice I
ON C.CustomerId = I.CustomerId
GROUP BY E.EmployeeId
-- Which sales agent made the most in sales in 2009?
SELECT [Sales Agent], MAX([Total Sales]) 
FROM ( SELECT Employee.FirstName || ' ' || Employee.LastName AS [Sales Agent],
 SUM(Invoice.Total) AS [Total Sales] 
 FROM Employee 
 INNER JOIN Customer ON Customer.SupportRepId = Employee.EmployeeId 
 INNER JOIN Invoice ON Invoice.CustomerId = Customer.CustomerId WHERE Invoice.InvoiceDate LIKE '%2009%' GROUP BY Employee.LastName )

-- Which sales agent made the most in sales over all?
SELECT 
E.FirstName,
E.LastName,
MAX(I.Total) AS "Total_Sales"
FROM Employee E
INNER JOIN Customer C
ON E.EmployeeId	= C.SupportRepId
INNER JOIN Invoice I
ON C.CustomerId = I.CustomerId
WHERE strftime('%Y', I.InvoiceDate) IN ('2009')
GROUP BY E.employeeId

-- Provide a query that shows the count of customers assigned to each sales agent.
SELECT 
E.FirstName, 
E.LastName,
COUNT(C.SupportRepId) AS "Total_Customers"
FROM Customer C
INNER JOIN Employee E 
ON C.SupportRepId E.EmployeeId
INNER JOIN Invoice I 
ON  C.CustomerId = I.CustomerId
GROUP BY E.employeeId;

SELECT 
CONCAT(E.FirstName, " ", E.LastName) AS "Full_Name",
COUNT(C.SupportRepId) AS "Total_Customers"
FROM Customer C
INNER JOIN Employee E 
ON C.SupportRepId E.EmployeeId
INNER JOIN Invoice I 
ON  C.CustomerId = I.CustomerId
GROUP BY E.employeeId;

-- Provide a query that shows the total sales per country.
SELECT 
I.BillingCountry,
SUM(I.Total) AS "Total_Sales"
FROM Invoice I
GROUP BY I.BillingCountry 
ORDER BY I.Total DESC

-- Which country's customers spent the most?

SELECT 
BillingCountry, 
SUM(Total) AS "Total Sales" 
FROM Invoice 
GROUP BY BillingCountry 
ORDER BY SUM(Total) DESC

-- Provide a query that shows the most purchased track of 2013.
SELECT 
T.TrackId, 
T.Name,
COUNT(IL.TrackId) AS "Times_Purchased"
FROM Track T
INNER JOIN InvoiceLine IL
ON T.TrackId = IL.TrackId 
INNER JOIN Invoice I
ON I.InvoiceId = IL.InvoiceId 
WHERE I.InvoiceDate 
LIKE '%2013%' 
GROUP BY T.TrackId 
ORDER BY COUNT(IL.TrackId) DESC
-- Provide a query that shows the top 5 most purchased tracks over all.
SELECT 
T.TrackId,
T.Name,  
COUNT(IL.TrackId) AS "Times Purchased" 
FROM Track T
INNER JOIN InvoiceLine IL
ON  T.TrackId = IL.TrackId
INNER JOIN Invoice I
ON IL.InvoiceId = I.InvoiceId 
GROUP BY T.TrackId 
ORDER BY COUNT(IL.TrackId) DESC 
LIMIT 5

-- Provide a query that shows the top 3 best selling artists.
SELECT
A.Name,
SUM(IV.UnitPrice) AS "Total_Price"
FROM Track T
INNER JOIN InvoiceLine Iv
ON T.TrackId = Iv.TrackId
INNER JOIN Invoice I
ON IV.InvoiceId = I.InvoiceId
INNER JOIN Album AB
ON T.AlbumId = AB.AlbumId
INNER JOIN Artist A
ON AB.ArtistId	= A.ArtistId	
GROUP BY A.Name 
ORDER BY SUM(IV.UnitPrice)DESC 
LIMIT 3

-- Provide a query that shows the most purchased Media Type.
SELECT 
M.Name,
MAX(InvoiceLineId) 
FROM MediaType M
INNER JOIN Track T
ON M.MediaTypeId = T.MediaTypeId 
INNER JOIN InvoiceLine IV
ON T.TrackId = IV.TrackId