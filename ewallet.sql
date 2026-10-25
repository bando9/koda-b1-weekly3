CREATE DATABASE ewallet_db;

DROP TABLE if EXISTS users CASCADE;
DROP TABLE if EXISTS accounts CASCADE;
DROP TABLE if EXISTS transactions CASCADE;
DROP TYPE IF EXISTS transaction_type CASCADE;
DROP TABLE IF EXISTS mutations CASCADE;

create table users(
    id int generated always as identity primary key,
    username VARCHAR(255) not null UNIQUE,
    password_hash VARCHAR(250) not null,
    email VARCHAR(100) not null UNIQUE, 
    photo TEXT,

    full_name VARCHAR(255) not null,
    phone VARCHAR(50) not null UNIQUE,
    created_at TIMESTAMP default now(),
    updated_at timestamp DEFAULT NOW()
);

create table accounts(
    id int generated always as identity PRIMARY KEY,
    account_number VARCHAR(100) not null UNIQUE,
    PIN_hash VARCHAR(255) NOT NULL,
    balance BIGINT not null check(balance >= 0),
    
    created_at TIMESTAMP default now(),
    updated_at TIMESTAMP default now(),
    
    user_id int NOT NULL UNIQUE,

    FOREIGN KEY (user_id) REFERENCES users(id)
);



create table transactions(
    id int generated always as identity PRIMARY KEY,
    reference_id varchar(200) not null UNIQUE,
    created_at TIMESTAMP default now(),
    updated_at TIMESTAMP default now()    
);

CREATE TYPE transaction_type AS ENUM ('income', 'expense');

create table mutations(
    id int generated ALWAYS AS IDENTITY PRIMARY KEY
    description VARCHAR(150),
    amount BIGINT check(amount>0),
    type transaction_type not null DEFAULT 'expense',

    account_id int not null,
    transaction_id int not null,

    FOREIGN KEY (account_id) REFERENCES accounts(id),
    FOREIGN KEY (transaction_id) REFERENCES transactions(id)
);


-- * =============================

-- TODO: Login
SELECT full_name, email
from users
where username like 'bando' and password_hash like 'bando123'; 

-- TODO: register
INSERT INTO users (full_name, username, password_hash, email, phone, photo) VALUES
('udin sedunia', 'udin-seduina', 'password_hash', 'udin@email.com', '+1 8902349', 'link to photo');


-- TODO: get user login (username, email, photo)