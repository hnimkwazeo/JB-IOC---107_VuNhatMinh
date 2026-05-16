--Phan 1: Tao csdl va bang
--Y1:
create table Patients(
	patient_id varchar(5) primary key,
	patient_full_name varchar(100) not null,
	patient_email varchar(100) not null,
	patient_phone varchar(15) not null,
	patient_cccd varchar(20) not null
);

create table Doctors(
	doctor_id varchar(5) primary key,
	doctor_name varchar(100) not null,
	specialization varchar(100) not null,
	consultation_fee decimal(10,2) not null
);

create table Appointments(
	appointment_id varchar(5) primary key,
	patient_id varchar(5) references patients(patient_id),
	doctor_id varchar(5) references doctors(doctor_id),
	appointment_date date not null,
	appointment_time time not null,
	diagnosis varchar(255)
);

create table Payments (
	payment_id varchar(5) primary key,
	appointment_id varchar(5) references appointments(appointment_id),
	payment_method varchar(50) not null,
	payment_date date not null,
	amount decimal(10,2) not null
);

--Y2
insert into patients(patient_id, patient_full_name, patient_email, patient_phone, patient_cccd) values 
('P001', 'Nguyễn Văn An', 'an.nguyen@gmail.com', '0912345678', '001234567890'),
('P002', 'Trần Thị Bình', 'binh.tran@gmail.com', '0923456789', '002345678901'),
('P003', 'Lê Hoàng Châu', 'chau.le@yahoo.com', '0934567890', '003456789012'),
('P004', 'Phạm Quốc Đạt', 'dat.pham@gmail.com', '0945678901', '004567890123'),
('P005', 'Võ Thanh Em', 'em.vo@gmail.com', '0956789012', '005678901234'),
('P006', 'Hoàng Minh Đức', 'duc.hoang@gmail.com', '0967890123', '006789012345'),
('P007', 'Đỗ Thị Hạnh', 'hanh.do@gmail.com', '0978901234', '007890123456'),
('P008', 'Bùi Gia Khang', 'khang.bui@yahoo.com', '0989012345', '008901234567');


insert into doctors(doctor_id, doctor_name, specialization, consultation_fee) values
('D001', 'BS. Nguyễn Minh', ' Nội tổng quát', 300000),
('D002', 'BS. Trần Hoa', 'Nhi khoa', 350000),
('D003', 'BS. Lê Anh', 'Tim mạch', 500000),
('D004', 'BS. Phạm Long', 'Da liễu', 400000),
('D005', 'BS. Võ Quang', 'Tai mũi họng', 250000),
('D006', 'BS. Hoàng Sơn', 'Xương khớp', 450000),
('D007', 'BS. Đặng Mai', 'Thần kinh', 550000),
('D008', 'BS. Bùi Khánh', 'Mắt', 320000);

insert into appointments(appointment_id, patient_id, doctor_id, appointment_date, appointment_time, diagnosis) values 
('A001', 'P001', 'D001', '2025-06-10', '08:00:00', 'Cảm cúm'),
('A002', 'P002', 'D002', '2025-06-11', '09:00:00', 'Sốt cao'),
('A003', 'P003', 'D003', '2025-06-12', '10:00:00', 'Đau tim'),
('A004', 'P004', 'D004', '2025-06-13', '14:00:00', 'Dị ứng da'),
('A005', 'P005', 'D005', '2025-06-14', '15:00:00', 'Viêm họng'),
('A006', 'P006', 'D006', '2025-06-15', '08:30:00', 'Đau khớp'),
('A007', 'P007', 'D007', '2025-06-16', '13:00:00', 'Đau đầu kéo dài'),
('A008', 'P008', 'D008', '2025-06-17', '16:00:00', 'Cận thị');

insert into payments(payment_id, appointment_id, payment_method, payment_date, amount) values 
('P001', 'A001', 'Cash', '2025-06-01', 300000),
('P002', 'A002', 'Credit Card', '2025-06-02', 350000),
('P003', 'A003', 'Bank Transfer', '2025-06-03', 500000),
('P004', 'A004', 'E-Wallet', '2025-06-03', 400000),
('P005', 'A005', 'Cash', '2025-06-05', 250000),
('P006', 'A006', 'Credit Card', '2025-06-06', 450000),
('P007', 'A007', 'Bank Transfer', '2025-06-07', 550000),
('P008', 'A008', 'E-Wallet', '2025-06-08', 320000);

--Y3
update doctors 
set consultation_fee = consultation_fee * (1 - 0.1) 
where specialization = 'Nội tổng quát';

--Y4
delete from payments 
where payment_method = 'E-Wallet' and amount < 500000;

--Phan 2: Truy van co ban
--Y5
select 
	patient_id as "Mã BN", 
	patient_full_name as "họ tên", 
	patient_email as "email", 
	patient_phone as "SĐT"
from patients
order by patient_full_name desc;

--Y6
select 
	doctor_id as "Mã BS", 
	doctor_name as "tên bác sĩ", 
	specialization as "chuyên khoa", 
	consultation_fee as "phí khám"
from doctors
order by consultation_fee asc;

--Y7
select 
	p.patient_full_name as "Tên bệnh nhân", 
	d.doctor_name as "tên bác sĩ", 
	a.appointment_date as "ngày khám", 
	a.appointment_time as " giờ khám"
from appointments a
join patients p on p.patient_id = a.patient_id 
join doctors d on d.doctor_id = a.doctor_id;

--Y8
select 
	p.patient_id as "Mã BN", 
	patient_full_name as "họ tên", 
	pt.payment_method as "phương thức thanh toán", 
	pt.amount as "số tiền"
from payments pt
join appointments a on pt.appointment_id = a.appointment_id
join patients p on p.patient_id = a.patient_id;

--Y9
select * from patients 
order by regexp_replace(trim(patient_full_name), '^.* ', '') desc
limit 3 offset 1;

--Phan 3: Truy van nang cao
--Y10:
select 
	p.patient_id, 
	p.patient_full_name, 
	p.patient_email, 
	p.patient_phone, 
	p.patient_cccd
from patients p
join appointments a on p.patient_id = a.patient_id
group by p.patient_id, a.appointment_id
having count(a.patient_id) >= 2;

--Y11
select 
	d.doctor_id, 
	d.doctor_name, 
	d.specialization, 
	d.consultation_fee
from doctors d
join appointments a on d.doctor_id = a.doctor_id
group by d.doctor_id, a.appointment_id
having count(a.doctor_id) > 3;

--Y12
select
	p.patient_id, 
	p.patient_full_name,
	p.patient_email, 
	p.patient_phone, 
	p.patient_cccd
from patients p
join appointments a on p.patient_id = a.patient_id
join payments pt on pt.appointment_id = a.appointment_id
where amount > 700000;

--Y13
select * from patients
where patient_full_name ilike '%Hoàng%' or patient_email like '%@gmail.com';

--Y14
select * from doctors
order by consultation_fee desc
limit 3 offset 3;

--Phan 4: View
--Y15
create view vw_UpcomingAppointments
select 
	p.patient_full_name as "Họ tên bệnh nhân", 
	d.doctor_name as "tên bác sĩ", 
	a.appointment_date as "ngày khám", 
	a.appointment_time as " giờ khám", 
	a.diagnosis as "chẩn đoán"
from patients p
join appointments a on p.patient_id = a.patient_id
join doctors d on d.doctor_id = a.doctor_id
where a.appointment_date > '2025-06-01';

--Y16
create view vw_HighPaymentPatients
select
	p.patient_id, 
	p.patient_full_name,
	p.patient_email, 
	p.patient_phone, 
	p.patient_cccd
from patients p
join appointments a on p.patient_id = a.patient_id
join payments pt on pt.appointment_id = a.appointment_id
where amount > 350000;

--Phan 5: Trigger
--Y17
create or replace function func_check_date()
returns trigger as $$
	begin 
		if new.appointment_date < current_date then 
			raise exception 'Ngày khám không hợp lệ';
		end if;
		return new;
	end;
$$ language plpgsql;
create trigger tg_check_appointment_date 
after insert or update 
on appointments
for each row
execute function func_check_date();

--Y18
create or replace function func_auto_create_payment()
returns trigger as $$
declare v_consultation_fee decimal(10,2);
	begin 
		select consultation_fee into v_consultation_fee
		from doctors
		where id = new.doctor_id; 

		if v_consultation_fee is null
		then 
			v_consultation_fee := 0;
		end if;

		insert into payments(payment_id, appointment_id, payment_method, payment_date, amount) values 
		new.
		new.id,
		

		


