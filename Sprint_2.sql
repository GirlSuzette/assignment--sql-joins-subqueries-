-- Get all invoices where the UnitPrice on the InvoiceLine is greater than $0.99.
SELECT 
  * 
FROM Invoice I
INNER JOIN InvoiceLine IL
ON I.InvoiceId = IL.InvoiceId
WHERE IL.UnitPrice > 0.99;
-- Get the InvoiceDate, customer FirstName and LastName, and Total from all invoices.
SELECT 
C.FirstName,
C.LastName,
I.InvoiceDate,
I.Total
FROM Invoice I
INNER JOIN Customer C
ON I.CustomerId = C.CustomerId
-- Get the customer FirstName and LastName and the support rep's FirstName and LastName from all customers.
-- Support reps are on the Employee table.
SELECT 
C.FirstName,
C.LastName,
E.FirstName,
E.LastName
FROM Customer C
INNER JOIN Employee E
ON C.SupportRepId= E.EmployeeId
-- Get the album Title and the artist Name from all albums.
SELECT 
A.Title,
Ar.Name
FROM Album A
INNER JOIN Artist Ar
ON A.ArtistId = Ar.ArtistId
-- Get all PlaylistTrack TrackIds where the playlist Name is Music.
SELECT
PLT.TrackId
FROM PlaylistTrack PLT
INNER JOIN Playlist P
ON PLT.PlaylistId = P.PlaylistId
WHERE P.Name = "Music"
-- Get all Track Names for PlaylistId 5.
SELECT 
T.Name,
PL.PlaylistId
FROM Track T
INNER JOIN PlaylistTrack PL
ON T.TrackId = PL.TrackId
WHERE PL.PlaylistId = 5
-- Get all Track Names and the playlist Name that they're on.
SELECT 
T.Name,
P.Name
FROM Track T
INNER JOIN PlaylistTrack PL
ON T.TrackId = PL.TrackId
INNER JOIN Playlist P
ON PL.PlaylistId = P.PlaylistId
-- Get all Track Names and Album Titles that are the genre "Alternative".
SELECT 
T.Name, 
A.Title,
FROM Track T
INNER JOIN Album A 
ON T.AlbumId = A.AlbumId
INNER JOIN Genre G 
ON T.GenreId = G.GenreId
WHERE G.Name = "Alternative";