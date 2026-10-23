CREATE DATABASE ewallet_db;

DROP TABLE users if EXISTS;
DROP TABLE account_category if EXISTS;
DROP TABLE transaction_category if EXISTS;
DROP TABLE accounts if EXISTS;
DROP TABLE contacts if EXISTS;
DROP TABLE transaction_type if EXISTS;
DROP TABLE reference_transaction if EXISTS;
DROP TABLE transactions if EXISTS;

create table users (
    id int generated always as identity primary key,
    full_name VARCHAR(255) not null,
    username VARCHAR(255) not null UNIQUE,
    password_hash VARCHAR(250) not null,
    email VARCHAR(100) not null UNIQUE, 
    phone VARCHAR(50) not null UNIQUE,
    photo TEXT,
    created_at TIMESTAMP default now(),
    updated_at timestamp DEFAULT NOW()
);

CREATE TABLE account_category(
    id int generated ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT now()
);

CREATE TABLE transaction_category(
    id int generated ALWAYS as IDENTITY PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT now() 
);

create table accounts (
    id int generated always as identity PRIMARY KEY,
    balance BIGINT not null check(balance >= 0),
    PIN_hash VARCHAR(255) NOT NULL,
    account_number VARCHAR(100) not null UNIQUE,
    created_at TIMESTAMP default now(),
    updated_at TIMESTAMP default now(),
    user_id int NOT NULL,
    account_category_id int not null,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (account_category_id) REFERENCES account_category(id)
);


create table transaction_type(
    id int generated ALWAYS as IDENTITY PRIMARY key,
    name VARCHAR(100) 
);


create table transactions (
    id int generated always as identity PRIMARY KEY,
    description VARCHAR(150),
    status VARCHAR(100) not null,
    amount BIGINT check(amount>0),
    created_at TIMESTAMP default now(),
    contact_id int,
    reference_id int null,
    transaction_type int not null,
    transaction_category_id int not null,

    FOREIGN KEY (reference_id) REFERENCES reference_transaction(id)
    FOREIGN KEY (account_id) REFERENCES accounts(id),
    FOREIGN KEY (contact_id) REFERENCES contacts(id),
    FOREIGN KEY (transaction_category_id) REFERENCES transaction_category(id)
);



-- * ========================================


-- * =============================

-- TODO: Login
SELECT full_name, email
from users
where username like 'bando' and password_hash like 'bando123'; 

-- TODO: register
INSERT INTO users (full_name, username, password_hash, email, phone, photo) VALUES
('udin sedunia', 'udin-seduina', 'password_hash', 'udin@email.com', '+1 8902349', 'link to photo');


-- TODO: get user login (username, email, photo)




--- * ======================================


create table users(
    -- * id,ca,ua
    -- * username, password_hash, email, photo
    -- * bisa lihat account balance, income, expense = dipisah di accounts. account_type
);

create table transaction_history(
    -- * id,ca,ua
    -- * transfer kemana
    -- * jumlah 
    -- * tanggal kirim (ca)
    -- * dari akun mana
    -- * 
);

CREATE TYPE transaction_type AS ENUM ('income', 'expense');
CREATE TYPE transaction_status AS ENUM ('success', 'failed', 'pending');

create table transactions(
    -- * id,ca,ua
    -- * sender_id, receiver_id
    -- * t_type, t_status, amount, description(optional)
    -- * 
);

create table accounts(
    -- * id,ca,ua
    -- * account_number, PIN, user_id
    -- * balance
);