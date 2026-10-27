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
    id int generated ALWAYS AS IDENTITY PRIMARY KEY,
    description VARCHAR(150),
    amount BIGINT check(amount>0),
    type transaction_type not null DEFAULT 'expense',

    account_id int not null,
    transaction_id int not null,

    FOREIGN KEY (account_id) REFERENCES accounts(id),
    FOREIGN KEY (transaction_id) REFERENCES transactions(id)
);


-- * =============================

INSERT INTO users (username, password_hash, email, photo, full_name, phone) VALUES
('bando', 'hash_pw_1', 'bando@email.com', 'url_photo_1', 'Bando Mega', '081200000001'),
('keysa', 'hash_pw_2', 'keysa@email.com', 'url_photo_2', 'Keysa Maharani', '081200000002'),
('dika', 'hash_pw_3', 'dika@email.com', 'url_photo_3', 'Dika Pratama', '081200000003'),
('nayati', 'hash_pw_4', 'nayati@email.com', 'url_photo_4', 'Nayati Ayu', '081200000004'),
('dany', 'hash_pw_5', 'dany@email.com', 'url_photo_5', 'Dany Setiawan', '081200000005'),
('budi', 'hash_pw_6', 'budi@email.com', 'url_photo_6', 'Budi Santoso', '081200000006'),
('siti', 'hash_pw_7', 'siti@email.com', 'url_photo_7', 'Siti Aminah', '081200000007'),
('joko', 'hash_pw_8', 'joko@email.com', 'url_photo_8', 'Joko Susilo', '081200000008'),
('rini', 'hash_pw_9', 'rini@email.com', 'url_photo_9', 'Rini Wulandari', '081200000009'),
('andi', 'hash_pw_10', 'andi@email.com', 'url_photo_10', 'Andi Saputra', '081200000010');

INSERT INTO accounts (account_number, PIN_hash, balance, user_id) VALUES
('88990001', 'hash_pin_1', 1500000, 1),
('88990002', 'hash_pin_2', 2500000, 2),
('88990003', 'hash_pin_3', 500000, 3),
('88990004', 'hash_pin_4', 3000000, 4),
('88990005', 'hash_pin_5', 100000, 5),
('88990006', 'hash_pin_6', 750000, 6),
('88990007', 'hash_pin_7', 4200000, 7),
('88990008', 'hash_pin_8', 0, 8),
('88990009', 'hash_pin_9', 800000, 9),
('88990010', 'hash_pin_10', 5000000, 10);

INSERT INTO transactions (reference_id) VALUES
('TRX-TOPUP-001'),       
('TRX-TRF-001'),         
('TRX-TRF-002'),         
('TRX-PAY-001'),        
('TRX-TOPUP-002'),      
('TRX-TRF-003'),         
('TRX-TRF-004'),         
('TRX-PAY-002'),         
('TRX-TOPUP-003'),       
('TRX-TRF-005');       

INSERT INTO mutations (description, amount, type, account_id, transaction_id) VALUES
('Top Up from BRIVA', 500000, 'income', 1, 1),
('Transfer to Keysa', 100000, 'expense', 1, 2),
('Transfer from Bando', 100000, 'income', 2, 2),
('Transfer to Nayati', 50000, 'expense', 3, 3),
('Transfer from Dika', 50000, 'income', 4, 3),
('Payment Google Play', 35000, 'expense', 5, 4),
('Top Up from BCA', 200000, 'income', 6, 5),
('Transfer to Siti', 150000, 'expense', 2, 6),
('Transfer from Keysa', 150000, 'income', 7, 6),
('Transfer to Rini', 25000, 'expense', 8, 7),
('Transfer from Joko', 25000, 'income', 9, 7),
('Payment PLN', 120000, 'expense', 10, 8),
('Top Up from Mandiri', 300000, 'income', 3, 9),
('Transfer to Bando', 75000, 'expense', 4, 10),
('Transfer from Nayati', 75000, 'income', 1, 10);


-- Tambahan 
INSERT INTO transactions (reference_id, created_at) VALUES
('TRX-20261001-001', '2026-10-01 08:30:00'), 
('TRX-20261002-002', '2026-10-02 12:15:00'), 
('TRX-20261005-003', '2026-10-05 19:45:00'), 
('TRX-20261010-004', '2026-10-10 10:00:00'), 
('TRX-20261012-005', '2026-10-12 14:20:00'), 
('TRX-20261015-006', '2026-10-15 09:10:00'), 
('TRX-20261018-007', '2026-10-18 21:00:00'), 
('TRX-20261020-008', '2026-10-20 11:30:00'), 
('TRX-20261022-009', '2026-10-22 16:05:00'),
('TRX-20261024-010', '2026-10-24 18:40:00'); 

INSERT INTO mutations (description, amount, type, account_id, transaction_id) VALUES
('Top Up BCA OneKlik', 1500000, 'income', 1, 11),
('Transfer makan malam', 250000, 'expense', 1, 12),
('Transfer dari Bando', 250000, 'income', 2, 12),
('Pembelian Steam Wallet', 150000, 'expense', 1, 13),
('Bayar utang project', 300000, 'expense', 3, 14),
('Pelunasan dari Dika', 300000, 'income', 1, 14),
('Transfer jajan', 75000, 'expense', 2, 15),
('Transfer dari Keysa', 75000, 'income', 3, 15),
('Top Up Mandiri Virtual Account', 500000, 'income', 2, 16),
('Pembayaran Tokopedia', 450000, 'expense', 1, 17),
('Transfer patungan', 120000, 'expense', 4, 18 ),
('Patungan dari Nayati', 120000, 'income', 2, 18 ),
('Transfer kopi', 50000, 'expense', 1, 19),
('Kopi dari Bando', 50000, 'income', 5, 19 ),
('Top Up BRIVA', 1000000, 'income', 1, 20 );


-- * =============================

-- TODO: Login
SELECT full_name, email, photo, phone
from users
where username = 'bando' and password_hash = 'hash_pw_1';

-- TODO: register

INSERT INTO users (username, password_hash, full_name, email, phone, photo) VALUES
('muhudin', 'hash_pw_11', 'Muhammad Syarifuddin Yanto', 'udinlagi@email.com', '+628902350', 'url_photo_udin')
RETURNING id;


-- TODO: get user login (username, email, photo)
select username, email, photo
from users where username = 'budi' and password_hash ='hash_pw_6';

-- TODO: Get/Check user PIN
select u.id as user_id, u.full_name, ac.account_number, ac.pin_hash
from users u
join accounts ac on u.id = ac.user_id
where u.id = 5;

-- TODO: Get transaction history

select u.full_name, tx.reference_id, tx.created_at, m.amount, m.type 
from transactions tx
join mutations m on tx.id = m.transaction_id
join accounts ac on ac.id = m.account_id
join users u on u.id = ac.user_id
where ac.user_id = 2
ORDER BY tx.created_at desc;


-- TODO:  Get user history with option (income/expense, date range)

select u.full_name, tx.created_at, m.amount, m.type 
from transactions tx
join mutations m on tx.id = m.transaction_id
join accounts ac on ac.id = m.account_id
join users u on u.id = ac.user_id
where user_id = 1 and m.type = 'income' and (tx.created_at between '01-10-2026' and '30-10-2026')
ORDER BY tx.created_at DESC;



-- TODO: Get user account information (balance, income, expense)

select u.full_name, ac.account_number, ac.balance, 
    sum(case when m.type = 'income' THEN m.amount else 0 end) as total_income,
    sum(case when m.type = 'expense' THEN m.amount else 0 end) as total_expense
from users u 
join accounts ac on ac.user_id = u.id
join mutations m on m.account_id = ac.id
where ac.user_id = 1
GROUP BY u.full_name, ac.account_number, ac.balance;


-- TODO: Find receiver with pagination

select u.full_name, m.type 
from transactions tx
join mutations m on m.transaction_id = tx.id
join accounts ac on ac.id = m.account_id
join users u on u.id = ac.user_id
where m.type = 'income'
limit 3
offset 0

-- TODO:  Create transaction/topup

INSERT INTO transactions (reference_id) values ('TRX-20261025-020') returning id;

INSERT INTO mutations (description, amount, type, account_id, transaction_id) VALUES
('beli diamond ML google play', 300000, 'expense', 1,22);

select u.full_name, m.description, m.amount, m.type from mutations m
join accounts ac on ac.id = m.account_id
join users u on u.id = ac.user_id 
where transaction_id = 22;


-- TODO:  Get user profile (photo, full name, phone, email) 

SELECT photo, full_name, phone, email
from users where id = 1; 


-- TODO: Change PIN

update accounts
set PIN_hash = '983521'
where user_id = 1
returning 'berhasil update PIN hash' as status;

-- TODO: Change password

update users 
set password_hash = 'password_hash_baru'
where id = 1
returning 'berhasil update password hash' as status;


-- TODO: Change user profile

update users
set photo = 'link_url_baru'
where id = 1 
returning photo;