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

select match_id, fixture, base_ticket_price from matches
where tournament_category like '%Champions League%' and  match_status = 'Available'