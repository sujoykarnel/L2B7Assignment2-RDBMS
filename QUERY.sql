-- =========================================================================
-- 1. CREATE USERS TABLE
-- =========================================================================
CREATE TABLE Users (
    user_id serial primary key,
    full_name varchar(100),
    email varchar(150) unique,
    role varchar(50) check (role in ('Ticket Manager', 'Football Fan'),
    phone_number varchar(20)
);


-- =========================================================================
-- 2. CREATE MATCHES TABLE
-- =========================================================================
CREATE TABLE matches (
    match_id serial primary key,
    fixture varchar(100),
    tournament_category varchar(100),
    base_ticket_price decimal(10,2) check (base_ticket_price >= 0) ,
    match_status varchar(20) check (match_status in ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
);


-- =========================================================================
-- 3. CREATE BOOKINGS TABLE
-- =========================================================================
CREATE TABLE bookings (
    booking_id serial primary key,
    user_id int references users(user_id),
    match_id int references matches(match_id),
    seat_number varchar(20),
    payment_status varchar(20) check (payment_status in ('Pending', 'Confirmed', 'Cancelled', 'Refunded')),
    total_cost decimal(10,2) check (total_cost >= 0)
    
);


-- =========================================================================
-- Query 1
-- =========================================================================
SELECT
    match_id,
    fixture,
    base_ticket_price
FROM
    matches
WHERE
    tournament_category = 'Champions League'
    AND match_status = 'Available';

-- =========================================================================
-- Query 2
-- =========================================================================
SELECT
    user_id,
    full_name,
    email
FROM
    users
WHERE
    full_name LIKE 'Tanvir%'
    OR full_name ILIKE '%Haque%';

-- =========================================================================
-- Query 3
-- =========================================================================
SELECT
    booking_id,
    user_id,
    match_id,
    coalesce(payment_status, 'Action Required') AS systematic_status
FROM
    bookings
WHERE
    payment_status IS NULL;

-- =========================================================================
-- Query 4
-- =========================================================================
SELECT
    booking_id,
    full_name,
    fixture,
    total_cost
FROM
    bookings AS b
    INNER JOIN users AS u ON b.user_id = u.user_id
    INNER JOIN matches AS m ON b.match_id = m.match_id;


-- =========================================================================
-- Query 5
-- =========================================================================
SELECT
    u.user_id,
    full_name,
    booking_id
FROM
    users AS u
    LEFT JOIN bookings AS b ON u.user_id = b.user_id;

-- =========================================================================
-- Query 6
-- =========================================================================
SELECT
    booking_id,
    match_id,
    total_cost
FROM
    bookings
WHERE
    total_cost > (
        SELECT
            avg(total_cost)
        FROM
            bookings
    );