insert into Users
(first_name, last_name, email, password)
values 
('Christopher', 'Wilson', 'cmw.wilson88@gmail.com', 'hunter22');

insert into Budgets
(name, to_be_budgeted, user_id)
values
('Test Budget', 0, 1),
('Main Budget', 0, 1);

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

insert into CatGroups
(name, month, year, budget_id)
values
('Immediate Obligations', 8, 2017, 1),
('True Expenses', 8, 2017, 1),
('Debt Payments', 8, 2017, 1),
('Quality of Life Goals', 8, 2017, 1),
('Just For Fun', 8, 2017, 1);

insert into spendcats
(name, month, year, budgeted, activity, catgroup_id, budget_id)
values
('Rent/Mortgage', 8, 2017, 899.00, 0, 1, 1),
('Electric', 8, 2017, 150, -150, 1, 1),
('Water', 8, 2017, 75, 0, 1, 1),
('Internet', 8, 2017, 79.99, -77.99, 1, 1),
('Groceries', 8, 2017, 500, -113.28, 1, 1),
('Transportation', 8, 2017, 50, -18.73, 1, 1),
('Interest & Fees', 8, 2017, 0, -55.23, 1, 1),
('Auto Maintenance', 8, 2017, 50, 0, 2, 1),
('Home Maintenance', 8, 2017, 100, 0, 2, 1),
('Renters/Home Insurance', 8, 2017, 21.23, 0, 2, 1),
('Medical', 8, 2017, 0, -35.00, 2, 1),
('Clothing', 8, 2017, 0, 0, 2, 1),
('Gifts', 8, 2017, 100, 0, 2, 1),
('Giving', 8, 2017, 0, 0, 2, 1),
('Computer Replacement', 8, 2017, 25, 0, 2, 1),
('Software Subscriptions', 8, 2017, 16.99, -9.99, 2, 1),
('Stuff I Forgot To Budget For', 8, 2017, 25, -8.50, 2, 1),
('Student Loan', 8, 2017, 1200, -1198.88, 3, 1),
('Auto Loan', 8, 2017, 300, -300, 3, 1),
('Vacation', 8, 2017, 100, 0, 4, 1),
('Fitness', 8, 2017, 30, -21.29, 4, 1),
('Dining Out', 8, 2017, 50, -21.75, 5, 1),
('Gaming', 8, 2017, 60, -45.43, 5, 1),
('Music', 8,2017, 0, -0, 5, 1),
('Fun Money', 8, 2017, 100, -85.59, 5, 1);

insert into transactions
(trans_date, account_id, payee_id, spend_cat_id, outflow, inflow, budget_id)
values
('2017-08-08',1, 2, 10, -500, 0, 1),
('2017-08-08',1, 2, 10, 0, 1000, 1),
('2017-08-08',2, 1, 17, -2000, 0, 1),
('2017-08-08',2, 1, 17, 0, 1000, 1),
('2017-08-08',3, 3, 23, -120, 0, 1),
('2017-08-08',3, 3, 23, 0, 200, 1);


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




