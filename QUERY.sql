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
