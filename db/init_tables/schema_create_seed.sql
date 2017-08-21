DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS budgets CASCADE;
DROP TABLE IF EXISTS accounts CASCADE;
DROP TABLE IF EXISTS payees CASCADE;
DROP TABLE IF EXISTS catgroups CASCADE;
drop table if exists catgroup_act cascade;
drop table if exists catgroup_month cascade;
drop table if exists spendcat_month cascade;
drop table if exists catgroup_avail cascade;
DROP TABLE IF EXISTS spendcats CASCADE;
drop table if exists spendcat_act cascade;
drop table if exists spendcat_avail cascade;
DROP TABLE IF EXISTS transactions CASCADE;


-- Users
CREATE TABLE IF NOT EXISTS Users (
	id serial primary key,
	first_name text not null,
	last_name text not null,
	email text unique not null,
	password text not null
);

-- Budgets
CREATE TABLE IF NOT EXISTS Budgets (
	id serial primary key,
	name text not null,
	to_be_budgeted decimal(14,2) not null,
	user_id integer not null,
	foreign key (user_id) references Users(id)
);

-- Accounts
CREATE TABLE IF NOT EXISTS Accounts (
	id serial primary key,
	name text not null,
	type text not null,
	amount decimal(14,2) default 0.00,
	uncleared decimal(14,2),
	cleared decimal(14,2),
	working decimal(14,2),
	budget_id integer not null,
	foreign key (budget_id) references Budgets(id)
);

-- Payees
CREATE TABLE IF NOT EXISTS Payees (
	id serial primary key,
	name text not null,
	budget_id integer not null,
	foreign key (budget_id) references Budgets(id)
);

-- Category Groups
CREATE TABLE IF NOT EXISTS CatGroups (
	id serial primary key,
	name text not null,
	-- month integer,
	-- year integer,
	-- budgeted decimal(14,2) default 0.00,
	-- activity decimal(14,2) default 0.00,
	-- available decimal(14,2) default 0.00,
	budget_id integer not null,
	foreign key (budget_id) references Budgets(id)
);

-- Category Group budget/activity by month
CREATE TABLE IF NOT EXISTS catgroup_act (
	id serial primary key,
	month integer,
	year integer,
	budgeted decimal(14,2) default 0.00,
	activity decimal(14,2) default 0.00,
	catgroup_id integer,
	foreign key (catgroup_id) references catgroups(id)
);

-- Category Group available total
CREATE TABLE IF NOT EXISTS catgroup_avail (
	id serial primary key,
	available decimal(14,2) default 0.00,
	month int, 
	year int,
	catgroup_id int,
	catgroup_act_id int,
	foreign key (catgroup_id) references CatGroups(id),
	foreign key (catgroup_act_id) references catgroup_act(id)
);

-- Spending Groups
CREATE TABLE IF NOT EXISTS SpendCats (
	id serial primary key,
	name text not null,
	-- month integer,
	-- year integer,
	type text default 'general',
	-- budgeted decimal(14,2) default 0,
	-- activity decimal(14,2) default 0,
	-- available decimal(14,2) default 0,
	catgroup_id integer not null,
	budget_id integer not null,
	foreign key (budget_id) references Budgets(id),
	foreign key (catgroup_id) references CatGroups(id) on delete cascade
);

CREATE TABLE IF NOT EXISTS spendcat_act (
	id serial primary key,
	month int,
	year int,
	budgeted decimal(14,2) default 0,
	activity decimal(14,2) default 0,
	spendcat_id integer,
	catgroup_act_id integer,
	foreign key (catgroup_act_id) references catgroup_act(id),
	foreign key (spendcat_id) references SpendCats(id) on delete cascade
);

CREATE TABLE IF NOT EXISTS spendcat_avail (
	id serial primary key,
	available decimal(14,2) default 0,
	month int,
	year int,
	spendcat_id integer,
	spendcat_act_id integer,
	catgroup_avail_id integer,
	foreign key (spendcat_id) references SpendCats(id),
	foreign key (spendcat_act_id) references spendcat_act(id) on delete cascade,
	foreign key (catgroup_avail_id) references catgroup_avail(id)
);

-- Transactions
CREATE TABLE IF NOT EXISTS Transactions (
	id serial primary key,
	trans_date text default 'date',
	month int,
	year int,
	account_id integer not null,
	payee_id integer not null,
	spend_cat_id integer not null,
	catgroup_act_id integer not null,
	type text,
	memo text default null,
	outflow decimal(14,2) default 0,
	inflow decimal(14,2) default 0,
	cleared boolean default FALSE,
	budget_id integer not null,
	foreign key (account_id) references Accounts(id),
	foreign key (payee_id) references Payees(id),
	foreign key (spend_cat_id) references SpendCats(id),
	foreign key (catgroup_act_id) references catgroup_act(id),
	foreign key (budget_id) references Budgets(id)
);