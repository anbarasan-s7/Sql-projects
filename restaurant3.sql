use restarent;
-- customer table
create table customer(
customer_id int primary key auto_increment,
customer_name varchar(30),
phone varchar(15)unique,
address text,
email_id varchar(50) not null
);
alter table customer add foreign key (payment_id) references payment (payment_id);
alter table customer auto_increment=101;
insert into customer (customer_name,phone,address,email_id) values 
('anbu','987654320','3 baby nagar','anbu234@gmail.com'),
('arasu','988654320','6 anna nagar','arasu5@gmail.com'),
('king','9876557420','3 raju nagar','king65@gmail.com');
update customer set payment_id=1301 where customer_id=101;
update customer set payment_id=1302 where customer_id=102;
update customer set payment_id=1303 where customer_id=103;
select*from customer;

-- Restaurent  table
create table restaurant(
restaurant_id int primary key ,
restaurant_name varchar(50),
location varchar(39),
contact_number varchar(30),
email_id varchar(30) not null
);
alter table restaurant drop column email_id;
insert into restaurant(restaurant_id,restaurant_name,location,contact_number) values
(1101,'annapoorani','chennai','1341-5443-52'),
(1102,'saravanabavan','trichy','9241-5003-492'),
(1103,'annapoorani','chennai','4541-548-5297');
select*from restaurant;


-- menuitem table
create table menuitem(
item_id int primary key auto_increment,
item_name varchar(50),
price decimal(10,2) not null,
catagery varchar(30),
restaurant_id int,
constraint fk_restaurant foreign key (restaurant_id) references restaurant (restaurant_id)
);
alter table menuitem auto_increment=701;
insert into menuitem (item_name,price,catagery,restaurant_id) values 
('biriyani',119.00,'seasoned',1101),
('friedrice',109.00,'asian',1102),
('noodls',99.00,'seasoned',1103);
select *from menuitem;


-- order item table
create table orderitem(
orderitem_id int primary key,
orderitem_name varchar(50),
item_id int,
quantity int not null,
total_price decimal(10,2) not null,
foreign key (item_id) references menuitem (item_id)
);
alter table orderitem add constraint fk_orderitem1 foreign key (customer_id) references customer(customer_id);
alter table orderitem add column customer_id int;
insert into orderitem (orderitem_id,orderitem_name,item_id,quantity,total_price) values
(321,'friedrice',702,1,109.00),
(322,'briyani',701,1,119.00),
(323,'noodles',703,2,198.00);
update orderitem set customer_id=101 where  orderitem_id=322;
update orderitem set customer_id=102 where  orderitem_id=321;
update orderitem set customer_id=103 where  orderitem_id=323;
select*from orderitem;


-- payment table
create table payment(
payment_id int primary key auto_increment,
orderitem_id int,
orderitem_name varchar(60),
payment_date datetime not null,
amount decimal(10,2) not null,
payment_method varchar(60),
constraint fk_orderitem foreign key (orderitem_id) references orderitem (orderitem_id)
);
select*from payment;
insert into payment (payment_id,orderitem_id,orderitem_name,payment_date,amount,payment_method) values
(1301,323,'noodles',now(),198.00,'G-PAY'),
(1302,322,'friedrice',now(),109.00,'UPI'),
(1303,321,'briyani',now(),119.00,'G-PAY');


-- delivary table
create table delivary(
delivery_id int primary key auto_increment,
orderitem_id int,
orderitem_name varchar(50),
delivary_address varchar(80),
delivary_date datetime not null,
delivary_status varchar(50) default 'pending',
restaurant_id int,
foreign key (orderitem_id) references orderitem (orderitem_id)
);
describe delivary;
alter table delivary add constraint fkk_restaurant foreign key (restaurant_id) references restaurant (restaurant_id);
insert into delivary (delivery_id,orderitem_id,orderitem_name,delivary_address,delivary_date,delivary_status,restaurant_id)values
(10921,321,'briyani','3 baby nagar',curdate()-interval 1 week,'G-PAY',701),
(10922,322,'friedrice','2 anna nagar',curdate()-interval 1 week,'UPI',702),
(10923,323,'briyani','4 raju nagar',curdate()-interval 1 week,'G-PAY',703);
select*from delivary;


-- inner join
select orderitem.orderitem_id,orderitem.orderitem_name,orderitem.quantity,orderitem.total_price,customer.customer_id,customer.customer_name
from orderitem join customer
on orderitem.customer_id=customer.customer_id;

-- creating view
create view ViewCustomer
as
select orderitem.orderitem_id,orderitem.orderitem_name,orderitem.quantity,orderitem.total_price,customer.customer_name
from orderitem join customer
on orderitem.customer_id=customer.customer_id;

select*from ViewCustomer
where customer_name='anbu';

-- Stored Procedure

delimiter //
create procedure customerinfo()
begin
	select*from ViewCustomer;
end //
delimiter ;













