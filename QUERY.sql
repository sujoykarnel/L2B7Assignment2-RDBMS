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
CREATE TABLE Matches (
    match_id serial primary key,
    fixture varchar(100),
    tournament_category varchar(100),
    base_ticket_price decimal(10,2) check (base_ticket_price >= 0) ,
    match_status varchar(20) check (match_status in ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
);
