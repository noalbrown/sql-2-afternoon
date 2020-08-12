-- Question #1

-- #1
SELECT *
FROM invoice_line
WHERE unit_price > 0.99;

-- #2
SELECT invoice.invoice_date, customer.first_name, customer.last_name, invoice.total
FROM invoice
  JOIN customer ON invoice.customer_id = customer.customer_id;

-- #3
SELECT customer.first_name, customer.last_name, employee.first_name, employee.last_name
FROM customer
  JOIN employee ON customer.support_rep_id = employee.employee_id;

-- #4
SELECT album.title, artist.name
FROM album
  JOIN artist ON album.artist_id = artist.artist_id;

-- #5
SELECT playlist_track.track_id
FROM playlist_track
  JOIN playlist ON playlist.playlist_id = playlist_track.playlist_id
WHERE playlist.name = 'Music';

-- #6
SELECT track.name
FROM track
  JOIN playlist_track ON playlist_track.track_id = track.track_id
WHERE playlist_track.playlist_id = 5;

-- #7
SELECT track.name, playlist.name
FROM track
  JOIN playlist_track ON track.track_id = playlist_track.track_id
  JOIN playlist ON playlist_track.playlist_id = playlist.playlist_id;

-- #8
SELECT track.name, album.title
FROM track
  JOIN album ON track.album_id = album.album_id
  JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name = 'Alternative & Punk';

-- Question #2

-- #1
SELECT *
FROM invoice
WHERE invoice_id IN ( SELECT invoice_id
FROM invoice_line
WHERE unit_price > 0.99 );

-- #2
SELECT *
FROM playlist_track
WHERE playlist_id IN ( SELECT playlist_id
FROM playlist
WHERE name = 'Music' );

-- #3
SELECT name
FROM track
WHERE track_id IN ( SELECT track_id
FROM playlist_track
WHERE playlist_id = 5 );

-- #4
SELECT *
FROM track
WHERE genre_id IN ( SELECT genre_id
FROM genre
WHERE name = 'Comedy' );

-- #5
SELECT *
FROM track
WHERE album_id IN ( SELECT album_id
FROM album
WHERE title = 'Fireball' );

-- #6
SELECT *
FROM track
WHERE album_id IN ( SELECT album_id
FROM album
WHERE artist_id IN ( SELECT artist_id
FROM artist
WHERE name = 'Queen'));

-- Question #3

-- #1
UPDATE customer
SET fax = null
WHERE fax IS NOT null;

-- #2
UPDATE customer
SET company = 'Self'
WHERE company IS null;

-- #3
UPDATE customer 
SET last_name = 'Thompson' 
WHERE first_name = 'Julia' AND last_name = 'Barnett';

-- #4
UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

-- #5
UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id = ( SELECT genre_id
  FROM genre
  WHERE name = 'Metal' )
  AND composer IS null;

-- Question #4

-- #1
SELECT COUNT(*), genre.name
FROM track
  JOIN genre ON track.genre_id = genre.genre_id
GROUP BY genre.name;

-- #2
SELECT COUNT(*), genre.name
FROM track
  JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name = 'Pop' OR genre.name = 'Rock'
GROUP BY genre.name;

-- #3
SELECT artist.name, COUNT(*)
FROM album
  JOIN artist ON artist.artist_id = album.artist_id
GROUP BY artist.name;

-- Question #5

-- #1
SELECT DISTINCT composer
FROM track;

-- #2
SELECT DISTINCT billing_postal_code
FROM invoice;

-- #3
SELECT DISTINCT company
FROM customer;

-- Question #6

-- #1
DELETE 
FROM practice_delete 
WHERE type = 'bronze';

-- #2
DELETE 
FROM practice_delete 
WHERE type = 'silver';

-- #3
DELETE 
FROM practice_delete 
WHERE value = 150;

-- Question #7

-- #1
CREATE TABLE users
(
  usersId SERIAL PRIMARY KEY,
  name TEXT,
  email TEXT
);

CREATE TABLE products
(
  productsId SERIAL PRIMARY KEY,
  name TEXT,
  price NUMERIC
);

CREATE TABLE orders
(
  ordersId SERIAL PRIMARY KEY,
  productsId INT REFERENCES products(productsId)
);

-- #2
INSERT INTO users
  (name, email)
VALUES
  ('Bob', 'bob@bobisawesome.com');

INSERT INTO users
  (name, email)
VALUES
  ('Sally', 'sally@sallyissilly.com');

INSERT INTO users
  (name, email)
VALUES
  ('Larry', 'larry@larryislooney.com');

INSERT INTO products
  (name, price)
VALUES
  ('bubblewrap', 1.99);

INSERT INTO products
  (name, price)
VALUES
  ('sillyputty', 2.99);

INSERT INTO products
  (name, price)
VALUES
  ('chalk', 0.99);

INSERT INTO orders
  (productsid)
VALUES
  (2);

INSERT INTO orders
  (productsid)
VALUES
  (4);

INSERT INTO orders
  (productsid)
VALUES
  (6);

-- #3
SELECT *
FROM orders
  JOIN products ON orders.ordersid = products.productsid;

SELECT *
FROM orders;

SELECT SUM(orders.ordersid*products.productsid)
FROM orders
  JOIN products ON orders.ordersid = products.productsid

-- #4
ALTER TABLE orders
ADD COLUMN usersid INT REFERENCES users
(usersid);

-- #5
SELECT users.name
From users
  JOIN orders ON users.usersid = orders.ordersid;

-- #6
SELECT *
FROM users.name
  JOIN orders ON users.usersid = orders;

SELECT *
FROM users.name
  JOIN orders ON users.usersid = orders.ordersid;

