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
	login_id text primary key,
	password text not null
);

create table customers(
	login_id text primary key,
	name text,
	mobile int,
	address text,
	cc_no text,
	foreign key(login_id) references users(login_id)
);

create table store_managers(
	login_id text primary key,
	foreign key(login_id) references users(login_id)
);

create table reviews(
	customer_id text not null,
	book_id text not null,
	score int not null,
	comment text,
	primary key(customer_id, book_id),
	foreign key(customer_id) references customers(login_id),
	foreign key(book_id) references books(isbn13),
	check(score>0 and score<11)
);

create table orders(
	id integer primary key,
	customer_id text not null,
	book_id text not null,
	copies int,
	order_date date,
	status text,
	foreign key(customer_id) references customers(login_id),
	foreign key(book_id) references books(isbn13),
	check (status = 'pending' or status = 'processed' or status = 'cancelled')
);

create table review_ratings(
	customer_id1 text not null,
	book_id text not null,
	customer_id2 text not null,
	rating int,
	primary key(customer_id1,customer_id2,book_id),
	foreign key(customer_id1) references customers(login_id),
	foreign key(customer_id2, book_id) references reviews(customer_id, book_id),
	check (rating>-1 and rating <4)
);
