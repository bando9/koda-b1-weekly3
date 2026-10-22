CREATE DATABASE ewallet_db;

create table users (
    id int generated always as identity,
    name VARCHAR(150) not null,
    NIK VARCHAR(100) not null UNIQUE,
    email VARCHAR(100) not null, 
    phone VARCHAR(50) not null,
    address VARCHAR(200),
    register_date TIMESTAMP default now(),
    created_at TIMESTAMP default now(),
    id_account int not null,

    FOREIGN KEY (id_account) REFERENCES account(id)
)


create table accounts {
    id int generated always as identity,
    current_amount int not null check(current_amount > 0),
    name VARCHAR(150) not null,
    account_number VARCHAR(100) not null,
    created_at TIMESTAMP default now(),
    updated_at TIMESTAMP default now(),
    id_user int not null,

    FOREIGN KEY (id_user) REFERENCES users(id)
}

create table transactions {
    id int generated always as identity,
    description VARCHAR(150),
    status VARCHAR(100) not null,
    account_number VARCHAR(100) not NULL,
    total_amount int check(total_amount>0),
    created_at TIMESTAMP default now(),
    transaction_date TIMESTAMP default now(),
    id_account int not null,
    id_user int not null,

    FOREIGN KEY (id_user) REFERENCES users(id),
    FOREIGN KEY (id_account) REFERENCES accounts(id)
}

INSERT INTO users (name, nik, email, phone, address) 
VALUES
('Budi Santoso', 'DUMMY-NIK-0001', 'budi@example.com','081200000001','Semarang, Jawa Tengah'),
('Siti Rahmawati','DUMMY-NIK-0002','siti@example.com','081200000002','Bekasi, Jawa Barat'),
('Andi Pratama','DUMMY-NIK-0003','andi@example.com','081200000003','Bogor, Jawa Barat'),
('Dewi Lestari','DUMMY-NIK-0004','dewi@example.com','081200000004','Jakarta Timur'),
('Rizky Firmansyah','DUMMY-NIK-0005','rizky@example.com','081200000005','Yogyakarta');



INSERT INTO accounts (current_amount,name,account_number,id_user) VALUES
(5000000, 'Tabungan Utama', 'ACC-DUMMY-0001', 1),
(2500000, 'Tabungan Harian', 'ACC-DUMMY-0002', 2),
(7500000, 'Tabungan Utama', 'ACC-DUMMY-0003', 3),
(1500000, 'Dana Darurat', 'ACC-DUMMY-0004', 4),
(3200000, 'Tabungan Utama', 'ACC-DUMMY-0005', 5);



INSERT INTO transactions (description,status,account_number,total_amount,transaction_date,id_account,id_user) VALUES
('Gaji bulanan','success','ACC-DUMMY-0001',5000000,'2026-10-01 09:00:00',1,1),
('Belanja kebutuhan','success','ACC-DUMMY-0002',250000,'2026-10-02 12:30:00',2,2),
('Transfer masuk','success','ACC-DUMMY-0003',1000000,'2026-10-03 10:15:00',3,3),
('Pembayaran listrik','pending','ACC-DUMMY-0004',350000,'2026-10-04 14:00:00',4,4),
('Pembelian barang','failed','ACC-DUMMY-0005',175000,'2026-10-05 16:45:00',5,5),
('Transfer ke rekening lain','success','ACC-DUMMY-0001',400000,'2026-10-06 11:20:00',1,1),
('Pembayaran internet','success','ACC-DUMMY-0002',300000,'2026-10-07 08:30:00',2,2),
('Belanja bulanan','pending','ACC-DUMMY-0003',650000,'2026-10-08 19:00:00',3,3),
('Isi ulang saldo','success','ACC-DUMMY-0004',200000,'2026-10-09 13:10:00',4,4),
('Pembelian tiket','success','ACC-DUMMY-0005',450000,'2026-10-10 17:30:00',5,5);