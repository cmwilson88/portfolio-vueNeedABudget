insert into Users
(first_name, last_name, email, password)
values 
('Christopher', 'Wilson', 'cmw.wilson88@gmail.com', 'hunter22');

insert into Budgets
(name, to_be_budgeted, user_id)
values
('Test Budget', 0.00, 1),
('Main Budget', 0.00, 1);

insert into Accounts
(name, type, budget_id)
values
('USAA Checking', 'Checking', 1),
('USAA Savings', 'Savings', 1),
('USAA Visa Credit Card', 'Credit Card', 1),
('US Bank Checking', 'Checking', 2),
('Chase Freedom', 'Credit Card', 2);

insert into Payees 
(name, budget_id)
values
('DevMountain', 1),
('Taco Bell', 1),
('Smiths', 1),
('Wal-Mart', 2),
('Best Buy', 2),
('Apple', 2);

-- Inflow Seed
with inflow_categories as (
	insert into catgroups
		(id, name, budget_id)
	values
		(DEFAULT, 'Inflow', 1)
	returning id
)
insert into spendcats
(name, type, catgroup_id, budget_id)
values
('Inflow: to be budgeted...', 'inflow', (select id from inflow_categories), 1);


-- Immediate Obligations Seed
with immediate_obs as (
	insert into catgroups
		(id, name, month, year, budget_id)
	values
		(DEFAULT, 'Immediate Obligations', 8, 2017, 1)
	returning id
)
insert into spendcats
(name, month, year, catgroup_id, budget_id)
values
('Rent/Mortgage', 8, 2017,  (select id from immediate_obs), 1),
('Electric', 8, 2017,  (select id from immediate_obs), 1),
('Water', 8, 2017,  (select id from immediate_obs), 1),
('Internet', 8, 2017,  (select id from immediate_obs), 1),
('Groceries', 8, 2017,  (select id from immediate_obs), 1),
('Transportation', 8, 2017,  (select id from immediate_obs), 1),
('Interest & Fees', 8, 2017,  (select id from immediate_obs), 1);

-- True expenses seed
with true_expenses as (
	insert into catgroups
		(id, name, budget_id)
	values
		(DEFAULT, 'True Expenses', 1)
	returning id
)
insert into spendcats
(name, month, year, catgroup_id, budget_id)
values
('Auto Maintenance', 8, 2017,  (select id from true_expenses), 1),
('Home Maintenance', 8, 2017,  (select id from true_expenses), 1),
('Renters/Home Insurance', 8, 2017,  (select id from true_expenses), 1),
('Medical', 8, 2017,  (select id from true_expenses), 1),
('Clothing', 8, 2017,  (select id from true_expenses), 1),
('Gifts', 8, 2017, (select id from true_expenses), 1),
('Giving', 8, 2017,  (select id from true_expenses), 1),
('Computer Replacement', 8, 2017,  (select id from true_expenses), 1),
('Software Subscriptions', 8, 2017,  (select id from true_expenses), 1),
('Stuff I Forgot To Budget For', 8, 2017,  (select id from true_expenses), 1);


-- Debt Payments
with debt_payments as (
	insert into catgroups
		(id, name, budget_id)
	values
		(DEFAULT, 'Debt Payments', 1)
	returning id
)
insert into spendcats
(name, month, year, catgroup_id, budget_id)
values
('Student Loan', 8, 2017, (select id from debt_payments), 1),
('Auto Loan', 8, 2017, (select id from debt_payments), 1);


-- Quality of Life Goals
with qol_goals as (
	insert into catgroups
		(id, name, budget_id)
	values
		(DEFAULT, 'Quality of Life Goals', 1)
	returning id
)
insert into spendcats
(name, month, year, catgroup_id, budget_id)
values
('Vacation', 8, 2017, (select id from qol_goals), 1),
('Fitness', 8, 2017, (select id from qol_goals), 1);

-- Just for Fun 
with just_fun as (
	insert into catgroups
		(id, name, budget_id)
	values
		(DEFAULT, 'Just For Fun', 1)
	returning id
)
insert into spendcats
(name, month, year, catgroup_id, budget_id)
values
('Dining Out', 8, 2017, (select id from just_fun), 1),
('Gaming', 8, 2017, (select id from just_fun), 1),
('Music', 8,2017,  (select id from just_fun), 1),
('Fun Money', 8, 2017, (select id from just_fun), 1);


update spendcats
	set available = budgeted + activity;

update catgroups
set
    budgeted = (select sum(budgeted) from spendcats where catgroup_id = catgroups.id),
        activity = (select sum(activity) from spendcats where catgroup_id = catgroups.id),
        available = (select sum(available) from spendcats where catgroup_id = catgroups.id);

        
update
    accounts
set
    amount = (select sum(outflow) + sum(inflow) from transactions where account_id = accounts.id)
where budget_id = 1;




