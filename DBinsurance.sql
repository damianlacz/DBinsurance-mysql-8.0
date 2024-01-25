create database insurance;
use insurance;

# Tabela klienci
create or replace table Customers(
ID_customer int auto_increment primary key,
First_name varchar(255) not null,
Last_name varchar(255) not null,
Customer_address varchar(255) not null,
Email varchar(255),
Age int not null,
Nationality varchar(255),
Phone_number varchar(15),
Date_of_birth datetime not null,
Has_relief bool not null
);


# Tabela agenci ubezpieczeniowi
create or replace table Insurance_agents(
ID_agent int auto_increment,
Full_name varchar(255),
Agent_phone varchar(15),
Agent_email varchar(255),
Company varchar(255),
primary key (ID_agent, Company)
)
partition by list columns(Company) (
partition WARTA values in ('WARTA') engine = InnoDB,
partition PZU values in ('PZU') engine = InnoDB,
partition Uniqua values in ('Uniqua') engine = InnoDB,
partition Aliens values in ('Aliens') engine = InnoDB,
partition TAURON values in ('TAURON') engine = InnoDB);



# typy ubezpieczen
# house - dom
# health - na zycie
# car - na samochod
# medical - medyczne
# other - inne
create or replace table Insurance_types(
ID int,
Type_of_insurance varchar(15)
);

insert into Insurance_types(ID, Type_of_insurance) values
(1, 'house'),
(2, 'health'),
(3, 'car'),
(4, 'medical'),
(5, 'other');

# Dane ubezpieczen
create or replace table Insurance(
ID_insurance int auto_increment primary key,
ID_customer int,
Name_customer varchar(255) not null,
Insurance_type varchar(255) not null,
Starting_date datetime not null,
Ending_date datetime not null,
Contribution double not null,
Other varchar(255),
foreign key (ID_customer) references Customers(ID_customer)
);
 
# Historia ubezpieczen
create or replace table Insurance_history(
ID_customer int,
ID_insurance int,
Name_customer varchar(255) default null,
Payment_date datetime default null,
Amount double default null,
foreign key (ID_customer) references Customers(ID_customer),
foreign key (ID_insurance) references Insurance(ID_insurance)
);

# Koszty ubezpieczen
create or replace table Insurance_cost(
ID_insurance int,
ID_customer int,
Name_Customer varchar(255),
Dwelling_value double,
Health_expenses double,
Medical_expenses double,
foreign key (ID_insurance) references Insurance(ID_insurance),
foreign key (ID_customer) references Customers(ID_customer)
);

# Lista statusow - tabela pomocnicza
create or replace table Status_list(
ID int,
Type_of_status varchar(20)
);

insert into Status_list(ID, Type_of_status) values
(1, "none"),
(2, "pending"),
(3, "occupied"),
(4, "occupied_with_relief"),
(5, "in_debt"),
(6, "");

# Tabela zazalenia
create or replace table Complaints(
ID_case int auto_increment primary key,
ID_customer int,
Name_customer varchar(255) default null,
Desc_complaint varchar(255) default null,
Complaint_date datetime default null,
foreign key (ID_customer) references Customers(ID_customer)
);

# Tabela wypadki
create or replace table Accidents(
ID_case int auto_increment primary key,
ID_customer int,
Name_customer varchar(255) default null,
Desc_accident varchar(255) default null,
Accident_date datetime default null,
foreign key (ID_customer) references Customers(ID_customer)
);

# Tabela statusy ubezpieczen klienow
create or replace table Insurance_status(
ID_customer int,
ID_insurance int,
Name_customer varchar(255) default null,
Status varchar(255) default null,
foreign key (ID_customer) references Customers(ID_customer),
foreign key (ID_insurance) references Insurance(ID_insurance)
);

# Tabela ulgi
create or replace table Reliefs(
ID_customer int,
Name_customer varchar(255),
Desc_relief varchar(255),
Amount double,
foreign key (ID_customer) references Customers(ID_customer)
);

# Tabela typ domu - gdyby zarejestrowany bylo ubezpieczenie na dom
create or replace table House_type(
ID_house int auto_increment primary key,
ID_customer int,
Name_customer varchar(255) default null,
Address varchar(255) default null,
`Type` varchar(255) default null,
Wall_covering bool default null,
dist_from_reserv_km int default null,
Heating_source varchar(255) default null,
Roof_material varchar(255) default null,
foreign key (ID_customer) references Customers(ID_customer)
);

# Tabela inne structury
create or replace table Other_structures(
ID_customer int,
Name_customer varchar(255),
`Structure` varchar(255),
foreign key (ID_customer) references Customers(ID_customer)
);

insert into Insurance_agents(Full_name, Agent_phone, Agent_email, Company) values
("Zofia Kozik", "513846342", "zofiakozik58@gmail.com", "WARTA"),
("Piotr Nowacki", "600123456", "piotr.nowacki@warta.com", "WARTA"),
("Anna Wisniewska", "502987654", "anna.wisniewska@pzu.com", "PZU"),
("Mateusz Kowalski", "505112233", "mateusz.kowalski@uniqua.com", "Uniqua"),
("Monika Malinowska", "501334455", "monika.malinowska@warta.com", "WARTA"),
("Krzysztof Szymanski", "504556677", "krzysztof.szymanski@pzu.com", "PZU"),
("Alicja Jankowska", "506778899", "alicja.jankowska@aliens.com", "Aliens"),
("Marcin Nowak", "503990011", "marcin.nowak@uniqua.com", "Uniqua"),
("Karolina Wojciechowska", "507112233", "karolina.wojciechowska@tauron.com", "TAURON"),
("Janusz Kowal", "501334455", "janusz.kowal@aliens.com", "Aliens"),
("Ewa Krawczyk", "509556677", "ewa.krawczyk@warta.com", "WARTA"),
("Michal Zajac", "501778899", "michal.zajac@uniqua.com", "Uniqua"),
("Agnieszka Piotrowska", "511990011", "agnieszka.piotrowska@pzu.com", "PZU"),
("Tomasz Lewandowski", "513112233", "tomasz.lewandowski@tauron.com", "TAURON"),
("Magdalena Slowik", "515334455", "magdalena.slowik@aliens.com", "Aliens"),
("Rafal Dabrowski", "517556677", "rafal.dabrowski@warta.com", "WARTA"),
("Karina Pawlak", "519778899", "karina.pawlak@pzu.com", "PZU"),
("Adam Kaczmarek", "521990011", "adam.kaczmarek@uniqua.com", "Uniqua"),
("Dominika Szulc", "523112233", "dominika.szulc@tauron.com", "TAURON"),
("Kamil Adamski", "525334455", "kamil.adamski@warta.com", "WARTA"),
("Natalia Majewska", "527556677", "natalia.majewska@pzu.com", "PZU"),
("Lukasz Gorecki", "529778899", "lukasz.gorecki@aliens.com", "Aliens"),
("Patrycja Wozniak", "531990011", "patrycja.wozniak@uniqua.com", "Uniqua"),
("Robert Mikolajczyk", "533112233", "robert.mikolajczyk@tauron.com", "TAURON"),
("Sylwia Jedrzejewska", "535334455", "sylwia.jedrzejewska@warta.com", "WARTA"),
("Kacper Nowicki", "537556677", "kacper.nowicki@pzu.com", "PZU"),
("Marta Zalewska", "539778899", "marta.zalewska@aliens.com", "Aliens"),
("Artur Sikora", "541990011", "artur.sikora@uniqua.com", "Uniqua"),
("Kinga Lis", "543112233", "kinga.lis@tauron.com", "TAURON"),
("Dawid Wojcik", "545334455", "dawid.wojcik@warta.com", "WARTA");



insert into Customers(First_name, Last_name, Customer_address, Email, Age, Nationality, Phone_number, Date_of_birth, Has_relief) values
("Jan", "Kowalski", "Moszna 34, Warsaw", "jankowalski@wp.pl", 55, "Polish", "111222333", "1968-05-29", 0),
("Kamil", "Nowak", "Jurna 88, Krakow", "kamil.nowak@onet.pl", 91, "Polish", "444355111", "1932-05-29", 1),
("Andrew", "Deep", "High Street 20, London", "andrew.deep@gmail.com", 48, "English", "667345112", "1975-05-29", 0),
("Marie", "Eurolla", "Carettera 14, Madrid", "marie_eurolla@gmail.com", 37, "Spanish", "998543112", "1986-05-29", 1),
("Milena", "Kastelik", "Pogodna 3, Gdansk", "milenakastelik123@wp.pl", 51, "Polish", "508224119", "1972-05-29", 1),
("Anna", "Wisniewska", "Sloneczna 10, Warsaw", "annawisniewska@gmail.com", 41, "Polish", "502111222", "1981-03-15", 0),
("Piotr", "Nowakowski", "Dluga 5, Krakow", "piotr.nowakowski@onet.pl", 29, "Polish", "600333444", "1992-07-22", 0),
("Marta", "Kowalczyk", "Klonowa 8, Warsaw", "marta.kowalczyk@wp.pl", 62, "Polish", "787555666", "1959-11-10", 0),
("Oliver", "Smith", "Oak Street 15, London", "oliver.smith@gmail.com", 35, "English", "447876543", "1986-09-18", 1),
("Sophie", "Johnson", "Maple Avenue 3, London", "sophie.johnson@hotmail.com", 27, "English", "778990011", "1994-04-05", 0),
("Alejandro", "García", "Calle Principal 21, Madrid", "alejandro.garcia@yahoo.es", 45, "Spanish", "600112233", "1976-08-30", 0),
("Isabel", "Martinez", "Avenida del Sol 7, Madrid", "isabel.martinez@gmail.com", 32, "Spanish", "667778899", "1990-02-12", 0),
("Lukas", "Schulz", "Hauptstrasse 12, Berlin", "lukas.schulz@web.de", 50, "German", "0151122334455", "1971-06-08", 0),
("Sabine", "Fischer", "Seestrasse 3, Berlin", "sabine.fischer@hotmail.de", 42, "German", "0176888999111", "1979-09-25", 0),
("Eva", "Novakova", "Namesti Republiky 6, Prague", "eva.novakova@email.cz", 98, "Czech", "777123456", "1993-12-07", 1);


call add_insurance(10, 'house', '2024-12-31 9:00:00', 1000, '');
call add_insurance(9, 'medical', '2024-12-31 9:00:00', 1000, 'lawn');
call add_insurance(3, 'health', '2024-12-31 9:00:00', 1000, 'extra house');

select * from Customers;
select * from insurance;
select * from insurance_cost;
select * from House_type;
select * from Other_structures;
select * from Insurance_history;
select * from Accidents;
select * from Complaints;
select * from Reliefs;

# Spr. widoki
select * from vCustomerDetails;
select * from vActiveStatus;
select * from vHouseInsurance;



# Dodawanie ubezpieczenia osobie
create or replace procedure add_insurance(in id int, in ins_type varchar(255), in end_date datetime, in contrib double, in other varchar(255))
begin
	declare `fn` varchar(255) default (select First_name from Customers as c where c.ID_customer = id);
	declare `ln` varchar(255) default (select Last_name from Customers as c where c.ID_customer = id);
	insert into Insurance(ID_customer, Name_customer, Insurance_type, Starting_date, Ending_date, Contribution, Other) values
	(id, concat(`fn`, ' ', `ln`), ins_type, now(), end_date, contrib, other);
end;



# Dodawanie zażalenia klientowi
create or replace procedure add_complaint(in id_cust int, in description varchar(255), in custom_date datetime)
begin
	declare first varchar(255); declare last varchar(255);
	
	select First_name, Last_name into `first`, `last`
	from Customers as cust where cust.ID_customer = id_cust;

	update Complaints 
		set Desc_complaint = description, Complaint_date = custom_date
	where ID_customer = id_cust;
end;

call add_complaint(9, 'long waiting times', now());
select * from Complaints;



# Dodawanie wypadku klientowi
create or replace procedure add_accident(in id_cust int, in description varchar(255), in acc_date datetime)
begin
	declare `first` varchar(255); declare `last` varchar(255);
	
	select First_name, Last_name into `first`, `last`
	from Customers as cust where cust.ID_customer = id_cust;
	
	update Accidents 
		set Desc_accident = description, Accident_date = acc_date
	where ID_customer = id_cust;
end;

#################################### Dodanie wypadku osobie o id = 10
call add_accident(10, 'Car accident', '2023-06-22 15:32:06');
select * from Accidents;



# Aktualizowanie informacji o typie domu klienta
create or replace procedure update_house_type(in customer_id int, in h_address varchar(255), in toh varchar(255), in wall bool, in dist_from_res int, in heating varchar(255), in roof_type varchar(255))
begin
	update House_type
		set Address = h_address, `Type` = toh, Wall_covering = wall, dist_from_reserv_km = dist_from_res, Heating_source = heating, Roof_material = roof_type
	where ID_customer = customer_id;
end;

call update_house_type(10, 'ul. Laczna 33', 'metal', true, 253, 'electricity', 'wooden');
select * from House_type;


############## aktualizowanie informacji dot domu osobie o id = 10, o adresie Lacznej 55, o typie domu drewnianym, czy ma pokryte sciany
############## odleglosc od najblizszego biura nieruchomosci (w km), typ oswietlenia (zrodlo) oraz typ dachu
call update_house_type(10, 'ul. Laczna 55', 'wooden', true, 500, 'electricity', 'metal');
select * from House_type;


# Funkcja

# amount - kwota ubezpieczenia do zapłaty
# age - wiek osoby ubiegającej się o ubezpieczenie
# type_of_relief - rodzaj przyznanej ulgi (age - ze względu na wiek, unique - unikalna ustalona indywidualnie, house - jeśli został ubezpieczony dom)
create or replace function calculate_relief(amount double, type_of_relief varchar(25), age int, unique_relief_percentage double) returns double # dla procedury
begin 
	declare relief_amount double default 0.0;
	if age > 80 and type_of_relief = 'age' then
		set relief_amount = amount*(1 - (age + 25)/100);
	elseif type_of_relief = 'unique' then
		set relief_amount = amount*unique_relief_percentage;
	elseif type_of_relief = 'house' then
		set relief_amount = amount*1.1;
	end if;
	return relief_amount;
end;



# Triggery
create or replace trigger add_statistics
after insert on Customers
for each row
begin 
	declare ins_cost double default (select Contribution from Insurance as i where i.ID_customer = new.ID_customer);
	if new.Has_relief = true then
		if new.Age > 70 then
			insert into Reliefs(ID_customer, Name_customer, Desc_relief, Amount) values
			(new.ID_customer, concat(new.First_name, ' ', new.Last_name), concat("Age > ", new.Age), (select calculate_relief(ins_cost, 'age', new.Age, 0.0)));
		elseif (select count(*) from house_type as ht where ht.ID_customer = new.ID_customer) > 0 then
			insert into Reliefs(ID_customer, Name_customer, Desc_relief, Amount) values
			(new.ID_customer, concat(new.First_name, ' ', new.Last_name), 'House relief', (select calculate_relief(ins_cost, 'unique', new.Age, 0.0)));
		else
			insert into Reliefs(ID_customer, Name_customer, Desc_relief, Amount) values
			(new.ID_customer, concat(new.First_name, ' ', new.Last_name), concat("unique per ", round((1.0-0.8)*rand() + 0.8, 2)), (select calculate_relief(ins_cost, 'house', new.Age, (1.0-0.8)*rand() + 0.8)));
		end if;
	else
		# Dodanie pozycji do ulg
		insert into Reliefs(ID_customer, Name_customer, Desc_relief, Amount) values
		(new.ID_customer, concat(new.First_name, ' ', new.Last_name), '', 0);
	end if;

	# Dodanie pozycji do zażaleń
	insert into Complaints(ID_customer, Name_customer, Desc_complaint, Complaint_date) values
	(new.ID_customer, concat(new.First_name, ' ', new.Last_name), '', null);

	# Dodanie pozycji do wypadków
	insert into Accidents(ID_customer, Name_customer, Desc_accident, Accident_date) values
	(new.ID_customer, concat(new.First_name, ' ', new.Last_name), '', null);
end;

##2 trigger
create or replace trigger update_insurance_history
after insert on Insurance
for each row
begin
	declare ins_type varchar(15) default (select Type_of_insurance from Insurance_types as it where new.Insurance_type = it.Type_of_insurance);

	insert into Insurance_status(ID_customer, ID_insurance, Name_customer, Status) values
	(new.ID_customer, new.ID_insurance, new.Name_customer, 'pending');
	
 	insert into Insurance_history(ID_customer, ID_insurance, Name_customer, Payment_date, Amount) values
 	(new.ID_customer, new.ID_insurance, new.Name_customer, now(), new.Contribution);
   
 	if new.Other != '' then
  		insert into Other_structures(ID_customer, Name_customer, `Structure`) values
  		(new.ID_customer, new.Name_customer, new.Other);
	end if;
	
	case
		when new.Insurance_type = 'house' then
			insert into House_type(ID_customer, Name_customer, Address, `Type`, Wall_covering, dist_from_reserv_km, Heating_source, Roof_material) values 
			(new.ID_customer, new.Name_customer, (select Customer_address from Customers as c where c.ID_customer = new.ID_customer), '', false, 0, '', '');
			
			insert into House_condition(ID_customer, House_condition, Roof_update, Electrical_update, Plumbing_update) values
			(new.ID_customer, 'Needs Maintenance', now(), now(), now());
		
			insert into Insurance_cost(ID_insurance, ID_customer, Name_customer, Dwelling_value, Health_expenses, Medical_expenses) values 
			(new.ID_insurance, new.ID_customer, new.Name_customer, new.Contribution, null, null);
			
		when new.Insurance_type = 'health' then
		
			insert into Insurance_cost(ID_insurance, ID_customer, Name_customer, Dwelling_value, Health_expenses, Medical_expenses) values
			(new.ID_insurance, new.ID_customer, new.Name_customer, null, new.Contribution, null);
		
		when new.Insurance_type = 'medical' then
		
			insert into Insurance_cost(ID_insurance, ID_customer, Name_customer, Dwelling_value, Health_expenses, Medical_expenses) values
			(new.ID_insurance, new.ID_customer, new.Name_customer, null, null, new.Contribution);
		
		else
		
			insert into Insurance_cost(ID_insurance, ID_customer, Name_customer, Dwelling_value, Health_expenses, Medical_expenses) values
			(new.ID_insurance, new.ID_customer, new.Name_customer, null, null, null);
		
	end case;
end;

# Procedura dodawania lub zmieniania statusu ubezpieczenia klientowi
create or replace procedure change_or_insert_insurance_status(in customer_id int, in insurance_id int, in stat varchar(20))
begin 
	if (select count(*) from Insurance_status as ins where ins.ID_customer = customer_id) = 0 then 
		insert into Insurance_status(ID_customer, ID_insurance, Name_customer, Status) values
		(customer_id, insurance_id, (select Name_customer from Insurance as i where i.iD_customer = customer_id), stat);
	else
		update Insurance_status set Status = stat where ID_customer = customer_id;
	end if;
end;

##3 trigger
create or replace trigger update_insurance_status
after insert on Insurance_cost
for each row 
begin
	if time_to_sec(datediff(now(), (select Ending_date from Insurance as i where i.ID_customer = new.ID_customer))) > 0 then
		call change_or_insert_insurance_status(new.ID_customer, new.ID_insurance, 'occupied');
	else
		call change_or_insert_insurance_status(new.ID_customer, new.ID_insurance, 'in_debt');
	end if;
end;


# Widoki

create or replace view vCustomerDetails as
select
	cust.ID_customer,
	cust.First_name,
	cust.Last_name,
	cust.Has_relief,
	rel.Desc_relief,
	comp.Complaint_date,
	comp.Desc_complaint,
	acc.Accident_date,
	acc.Desc_accident
from Customers as cust
right join Reliefs as rel on cust.ID_customer = rel.ID_customer
right join Complaints as comp on cust.ID_customer = comp.ID_customer
right join Accidents as acc on cust.ID_customer = acc.ID_customer;


create or replace view vActiveStatus as
select
	c.ID_customer,
	c.First_name,
	c.Last_name,
	c.Email,
	c.Phone_number,
	i.Insurance_type,
	i.Other,
	ins.Status,
	inh.Payment_date,
	inh.Amount
from Customers as c
right join Insurance as i on c.ID_customer = i.ID_customer
right join Insurance_status as ins on c.ID_customer = ins.ID_customer
right join Insurance_history as inh on c.ID_customer = inh.ID_customer;
	

create or replace view vHouseInsurance as
select
	c.ID_customer,
	c.First_name,
	c.Last_name,
	c.Customer_address,
	os.`Structure`,
	inc.Dwelling_value,
	inc.Health_expenses,
	inc.Medical_expenses
from Insurance_cost as inc
left join Other_structures as os on  os.ID_customer = inc.ID_customer
left join Customers as c on inc.ID_customer = c.ID_customer;


#indeksy
create index idx_customer_id on Customers(ID_customer);
create index idx_insurance_id on Insurance(ID_insurance);
create index idx_agent_id on Insurance_agents(ID_agent);