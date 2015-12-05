create table books(
	isbn13 text primary key,
	title text,
	format text,
	publisher text,
	year_of_publication int,
	copies int,
	keywords text,
	subject text,
	price decimal,
	authors text,
	check(length(isbn13)<15),
	check(format = 'softcover' or format = 'hardcover')
);

create table users(
	id serial primary key,
	login_id text unique,
	password_digest text not null
);

create table customers(
	id integer primary key,
	name text,
	mobile int,
	address text,
	cc_no text,
	foreign key(id) references users(id) on delete cascade 
);

create table store_managers(
	id integer primary key,	 
	name text,
	foreign key(id) references users(id)
);

create table reviews(
	customer_id integer not null,
	book_id text not null,
	score int not null,
	comment text,
	primary key(customer_id, book_id),
	foreign key(customer_id) references customers(id),
	foreign key(book_id) references books(isbn13),
	check(score>0 and score<11)
);

create table orders(
	id serial primary key,
	customer_id integer not null,
	order_date date,
	status text,
	foreign key(customer_id) references customers(id),
	check (status = 'pending' or status = 'processed' or status = 'cancelled')
);

create table order_items(
	order_id integer,
	book_id text,
	copies int not null,
	primary key(order_id, book_id),
	foreign key(book_id) references books(isbn13),
	foreign key(order_id) references orders(id)
);


create table review_ratings(
	customer_id1 integer not null,
	book_id text not null,
	customer_id2 integer not null,
	rating int,
	primary key(customer_id1,customer_id2,book_id),
	foreign key(customer_id1) references customers(id),
	foreign key(customer_id2, book_id) references reviews(customer_id, book_id),
	check (rating>-1 and rating <4)
);
