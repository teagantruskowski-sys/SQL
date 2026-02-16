--Show Customers (their full names, customer ID, and country) who are not in the US. (Hint: != or <> can be used to say "is not equal to").
SELECT 
    CustomerId, 
    FirstName, 
    LastName, 
    Country
FROM chinook.customers
WHERE Country <> 'USA';

--Show only the Customers from Brazil.

SELECT * FROM chinook.customers 
WHERE Country = "Brazil" ;


--Find the Invoices of customers who are from Brazil. The resulting table should show the customer's full name, Invoice ID, Date of the invoice, and billing country.

SELECT 
    FirstName, 
    LastName, 
    InvoiceId, 
    InvoiceDate, 
    BillingCountry
FROM chinook.customers
JOIN chinook.invoices ON customers.CustomerId = invoices.CustomerId
WHERE Country = "Brazil";

--Show the Employees who are Sales Agents.

SELECT 
    FirstName, 
    LastName, 
    Title, 
    EmployeeId
FROM chinook.employees
WHERE Title = "Sales Support Agent";

--Find a unique/distinct list of billing countries from the Invoice table.

SELECT DISTINCT 
    BillingCountry
FROM chinook.invoices;

--Provide a query that shows the invoices associated with each sales agent. The resulting table should include the Sales Agent's full name.

SELECT 
    employees.FirstName, 
    employees.LastName, 
    invoices.InvoiceId, 
    invoices.InvoiceDate, 
    invoices.Total
FROM chinook.employees
JOIN chinook.customers ON employees.EmployeeId = customers.SupportRepId
JOIN chinook.invoices ON customers.CustomerId = invoices.CustomerId
WHERE employees.Title = "Sales Support Agent";

--Show the Invoice Total, Customer name, Country, and Sales Agent name for all invoices and customers.

SELECT 
    invoices.Total, 
    customers.FirstName, 
    customers.LastName, 
    customers.Country, 
    employees.FirstName, 
    employees.LastName
FROM chinook.employees
JOIN chinook.customers ON employees.EmployeeId = customers.SupportRepId
JOIN chinook.invoices ON customers.CustomerId = invoices.CustomerId;

--How many Invoices were there in 2009?

SELECT COUNT(InvoiceId)
FROM chinook.invoices
WHERE InvoiceDate LIKE "2009%";

--What are the total sales for 2009?

SELECT SUM(Total)
FROM chinook.invoices
WHERE InvoiceDate LIKE "2009%";

--Write a query that includes the purchased track name with each invoice line ID.

SELECT 
    invoice_items.InvoiceLineId, 
    tracks.Name
FROM chinook.invoice_items
JOIN chinook.tracks ON invoice_items.TrackId = tracks.TrackId;

--Write a query that includes the purchased track name AND artist name with each invoice line ID.

SELECT 
    invoice_items.InvoiceLineId, 
    tracks.Name AS TrackName, 
    artists.Name AS ArtistName
FROM chinook.invoice_items
JOIN chinook.tracks ON invoice_items.TrackId = tracks.TrackId
JOIN chinook.albums ON tracks.AlbumId = albums.AlbumId
JOIN chinook.artists ON albums.ArtistId = artists.ArtistId;

--Provide a query that shows all the Tracks, and include the Album name, Media type, and Genre.

SELECT 
    tracks.Name AS TrackName, 
    albums.Title AS AlbumTitle, 
    media_types.Name AS MediaType, 
    genres.Name AS Genre
FROM chinook.tracks
JOIN chinook.albums ON tracks.AlbumId = albums.AlbumId
JOIN chinook.media_types ON tracks.MediaTypeId = media_types.MediaTypeId
JOIN chinook.genres ON tracks.GenreId = genres.GenreId;

--Show the total sales made by each sales agent.

SELECT 
    employees.FirstName, 
    employees.LastName, 
    SUM(invoices.Total) AS TotalSales
FROM chinook.employees
JOIN chinook.customers ON employees.EmployeeId = customers.SupportRepId
JOIN chinook.invoices ON customers.CustomerId = invoices.CustomerId
WHERE employees.Title = "Sales Support Agent"
GROUP BY employees.EmployeeId;

--Which sales agent made the most dollars in sales in 2009?

SELECT 
    employees.FirstName, 
    employees.LastName, 
    SUM(invoices.Total) AS TotalSales
FROM chinook.employees
JOIN chinook.customers ON employees.EmployeeId = customers.SupportRepId
JOIN chinook.invoices ON customers.CustomerId = invoices.CustomerId
WHERE employees.Title = "Sales Support Agent" 
  AND invoices.InvoiceDate LIKE "2009%"
GROUP BY employees.EmployeeId
ORDER BY TotalSales DESC
LIMIT 1;

--Which 5 genres have the most tracks in the database?

SELECT 
    genres.Name, 
    COUNT(tracks.TrackId) AS TrackCount
FROM chinook.genres
JOIN chinook.tracks ON genres.GenreId = tracks.GenreId
GROUP BY genres.Name
ORDER BY TrackCount DESC
LIMIT 5;

--Which customer has spent the most money in total across all their invoices?

SELECT 
    customers.CustomerId, 
    customers.FirstName, 
    customers.LastName, 
    SUM(invoices.Total) AS TotalSpent
FROM chinook.customers
JOIN chinook.invoices ON customers.CustomerId = invoices.CustomerId
GROUP BY customers.CustomerId
ORDER BY TotalSpent DESC
LIMIT 1;

--Which country has the highest average invoice total?

SELECT 
    BillingCountry, 
    AVG(Total) AS AverageInvoiceAmount
FROM chinook.invoices
GROUP BY BillingCountry
ORDER BY AverageInvoiceAmount DESC
LIMIT 1;
