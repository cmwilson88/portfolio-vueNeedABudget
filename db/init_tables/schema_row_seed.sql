insert into Users
(first_name, last_name, email, password)
values 
('Christopher', 'Wilson', 'cmw.wilson88@gmail.com', 'hunter22');

insert into Budgets
(name, user_id)
values
('Test Budget', 1),
('Main Budget', 1);

insert into Accounts
(name, type, amount, budget_id)
values
('USAA Checking', 'Checking', 15439.53, 1),
('USAA Savings', 'Savings', 2500, 1),
('USAA Visa Credit Card', 'Credit Card', -10900, 1),
('US Bank Checking', 'Checking', 1.50, 2),
('Chase Freedom', 'Credit Card', -5000, 2);

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
('Rent/Mortgage', 8, 2017, 899.00, -450.00, 1, 1),
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
('08/11/2017', 1, 2, 7, 10900, 0, 1),
('08/12/2017', 2, 5, 15, 0, 2123, 1),
('08/12/2017', 2, 5, 23, 0, 2123, 1),
('08/13/2017', 3, 3, 17, 1239485242, 0, 1),
('08/12/2017', 2, 1, 20, 2043, 0, 2),
('08/12/2017', 2, 2, 10, 0, 2123, 2);

update spendcats
	set available = budgeted + activity




