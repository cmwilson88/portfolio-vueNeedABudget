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
('Starting Balance', 1);


-- Inflow Seed
with inflow_categories as (
	insert into catgroups
		(id, name, budget_id)
	values
		(DEFAULT, 'Inflow', 1)
	returning id
),
inflow_act as (
	insert into catgroup_act
		(id, month, year, catgroup_id)
	values
		(default, 8, 2017, (select id from inflow_categories))
	returning id
),
inflow_avail as (
	insert into catgroup_avail
		(month, year,catgroup_id, catgroup_act_id)
	values
		(8, 2017, (select id from inflow_categories), (select id from inflow_act))
	returning id
),
new_inflow as (
	insert into spendcats
		(id, name, type, catgroup_id, budget_id)
	values
		(default, 'Inflow: to be budgeted...', 'inflow', (select id from inflow_categories), 1)
	returning id
),
new_inflow_act as (
	insert into spendcat_act
		(id, month, year, spendcat_id, catgroup_act_id)
	values
		(default, 8, 2017, (select id from new_inflow), (select id from inflow_act))
	returning id
)
insert into spendcat_avail
	(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
values
	(8, 2017, (select id from new_inflow), (select id from new_inflow_act), (select id from inflow_avail));


-- Immediate Obligations Seed
with immediate_obs as (
	insert into catgroups
		(id, name, budget_id)
	values
		(DEFAULT, 'Immediate Obligations', 1)
	returning id
),
immediate_obsact as (
	insert into catgroup_act
		(id, month, year, catgroup_id)
	values
		(default, 8, 2017, (select id from immediate_obs))
	returning id
),
io_avail as (
	insert into catgroup_avail
		(month, year, catgroup_id, catgroup_act_id)
	values
		(8, 2017, (select id from immediate_obs), (select id from immediate_obsact))
	returning id
),
newio8 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Interest & Fees', (select id from immediate_obs), 1)
		returning id
),
newio8act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default,8, 2017, (select id from newio8), (select id from immediate_obsact))
		returning id
),
newio8avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		(8, 2017, (select id from newio8), (select id from newio8act), (select id from io_avail))
),
newio7 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Transportation', (select id from immediate_obs), 1)
		returning id
),
newio7act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default,8, 2017, (select id from newio7), (select id from immediate_obsact))
		returning id
),
newio7avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		(8, 2017, (select id from newio7), (select id from newio7act), (select id from io_avail))
),
newio6 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Groceries', (select id from immediate_obs), 1)
		returning id
),
newio6act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default, 8, 2017, (select id from newio6), (select id from immediate_obsact))
		returning id
),
newio6avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		(8, 2017, (select id from newio6), (select id from newio6act), (select id from io_avail))
),
newio5 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Electric', (select id from immediate_obs), 1)
		returning id
),
newio5act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default, 8, 2017, (select id from newio5), (select id from immediate_obsact))
		returning id
),
newio5avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		(8, 2017, (select id from newio5), (select id from newio5act), (select id from io_avail))
),
newio4 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Internet', (select id from immediate_obs), 1)
		returning id
),
newio4act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default,8, 2017, (select id from newio4), (select id from immediate_obsact))
		returning id
),
newio4avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		(8, 2017, (select id from newio4), (select id from newio4act), (select id from io_avail))
),
newio3 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Water', (select id from immediate_obs), 1)
		returning id
),
newio3act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default,8, 2017, (select id from newio3), (select id from immediate_obsact))
		returning id
),
newio3avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		(8, 2017, (select id from newio3), (select id from newio3act), (select id from io_avail))
),
newio2 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Electric', (select id from immediate_obs), 1)
		returning id
),
newio2act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default,8, 2017, (select id from newio2), (select id from immediate_obsact))
		returning id
),
newio2avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		(8, 2017, (select id from newio2), (select id from newio2act), (select id from io_avail))
),
newio1 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Rent/Mortgage', (select id from immediate_obs), 1)
		returning id
),
newio1act as (
	insert into spendcat_act
		(id, month, year, spendcat_id, catgroup_act_id)
	values
		(default, 8, 2017, (select id from newio1), (select id from immediate_obsact))
		returning id
),
newio1avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		(8, 2017, (select id from newio1), (select id from newio1act), (select id from io_avail))
)
select * from immediate_obs;



-- True expenses seed
with true_expenses as (
	insert into catgroups
		(id, name, budget_id)
	values
		(DEFAULT, 'True Expenses', 1)
	returning id
),
texpens_act as (
	insert into catgroup_act
		(month, year, catgroup_id)
	values
		(8, 2017, (select id from true_expenses))
	returning id
),
expense_avail as (
	insert into catgroup_avail
		(month, year, catgroup_id, catgroup_act_id)
	values
		(8, 2017,(select id from true_expenses), (select id from texpens_act))
	returning id
),
newte10 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Stuff I Forgot To Budget For', (select id from true_expenses), 1)
	returning id
),
newte10act as (
	insert into spendcat_act
		(id, month, year, spendcat_id, catgroup_act_id)
	values
		(default,8, 2017,  (select id from newte10), (select id from texpens_act))
	returning id
),
newte10avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		(8, 2017,(select id from newte10), (select id from newte10act), (select id from expense_avail))
),
newte9 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Software Subscriptions', (select id from true_expenses), 1)
		returning id
),
newte9act as (
	insert into spendcat_act
		(id, month, year, spendcat_id, catgroup_act_id)
	values
		(default,8, 2017, (select id from newte9), (select id from texpens_act))
	returning id
),
newte9avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		(8, 2017, (select id from newte9), (select id from newte9act), (select id from expense_avail))
),
newte8 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Computer Replacement', (select id from true_expenses), 1)
		returning id
),
newte8act as (
	insert into spendcat_act
		(id, month, year, spendcat_id, catgroup_act_id)
	values
		(default,8, 2017, (select id from newte8), (select id from texpens_act))
	returning id
),
newte8avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		(8, 2017, (select id from newte8), (select id from newte8act), (select id from expense_avail))
),
newte7 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Giving', (select id from true_expenses), 1)
		returning id
),
newte7act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default,8, 2017, (select id from newte7), (select id from texpens_act))
		returning id
),
newte7avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		(8, 2017, (select id from newte7), (select id from newte7act), (select id from expense_avail))
),
newte6 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Gifts',(select id from true_expenses), 1)
		returning id
),
newte6act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default,8, 2017, (select id from newte6), (select id from texpens_act))
		returning id
),
newte6avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		(8, 2017, (select id from newte6), (select id from newte6act), (select id from expense_avail))
),
newte5 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Clothing', (select id from true_expenses), 1)
		returning id
),
newte5act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default,8, 2017, (select id from newte5), (select id from texpens_act))
		returning id
),
newte5avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		(8, 2017, (select id from newte5), (select id from newte5act), (select id from expense_avail))
),
newte4 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Medical', (select id from true_expenses), 1)
		returning id
),
newte4act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default,8, 2017, (select id from newte4), (select id from texpens_act))
	returning id 
),
newte4avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		(8, 2017, (select id from newte4), (select id from newte4act), (select id from expense_avail))
),
newte3 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Renters/Home Insurance', (select id from true_expenses), 1)
		returning id
),
newte3act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default,8, 2017, (select id from newte3), (select id from texpens_act))
	returning id 
),
newte3avail as (
	insert into spendcat_avail
		(month, year,spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		(8, 2017,(select id from newte3), (select id from newte3act), (select id from expense_avail))
),
newte2 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
	 	(default, 'Home Maintenance', (select id from true_expenses), 1)
		returning id
),
newte2act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default,8, 2017, (select id from newte2), (select id from texpens_act))
	returning id 
),
newte2avail as (
	insert into spendcat_avail
		(month, year,spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		(8, 2017,(select id from newte2), (select id from newte2act), (select id from expense_avail))
),
newte1 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Auto Maintenance', (select id from true_expenses), 1)
		returning id
),
newte1act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default, 8, 2017, (select id from newte1), (select id from texpens_act))
		returning id
),
newte1avail as (
	insert into spendcat_avail
		(month, year,spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		(8, 2017, (select id from newte1), (select id from newte1act), (select id from expense_avail))
)
select * from true_expenses;



with debt_payments as (
	insert into catgroups
		(id, name, budget_id)
	values
		(DEFAULT, 'Debt Payments', 1)
	returning id
),
dpay_act as (
	insert into catgroup_act
		(month, year, catgroup_id)
	values
		(8, 2017, (select id from debt_payments))
	returning id
),
dpay_avail as (
	insert into catgroup_avail
		(month, year, catgroup_id, catgroup_act_id)
	values
		(8, 2017, (select id from debt_payments), (select id from dpay_act))
	returning id
),
newdp2 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default,'Auto Loan', (select id from debt_payments), 1)
		returning id
),
newdp2act as (
	insert into spendcat_act
		(id, month, year, spendcat_id, catgroup_act_id)
	values
		(default, 8, 2017, (select id from newdp2), (select id from dpay_act))
		returning id
),
newdp2avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
	(8, 2017, (select id from newdp2), (select id from newdp2act), (select id from dpay_avail))
),
newdp1 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default,'Student Loan',(select id from debt_payments), 1)
		returning id
),
newdp1act as (
	insert into spendcat_act
		(id, month, year, spendcat_id, catgroup_act_id)
	values
		(default, 8, 2017,  (select id from newdp1), (select id from dpay_act))
		returning id
),
newdp1avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		(8, 2017, (select id from newdp1), (select id from newdp1act), (select id from dpay_avail))
)
select * from debt_payments;


-- Quality of Life Goals
with qol_goals as (
	insert into catgroups
		(id, name,budget_id)
	values
		(DEFAULT, 'Quality of Life Goals', 1)
	returning id
),
qol_act as (
	insert into catgroup_act
		(month, year, catgroup_id)
	values
		(8, 2017, (select id from qol_goals))
	returning id
),
qol_avail as (
	insert into catgroup_avail
		(month, year, catgroup_id, catgroup_act_id)
	values
		(8, 2017, (select id from qol_goals), (select id from qol_act))
	returning id
),
newqg2 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Fitness', (select id from qol_goals), 1)
		returning id
),
newqg2act as (
	insert into spendcat_act
		(id, month, year, spendcat_id, catgroup_act_id)
	values
		(default, 8, 2017, (select id from newqg2), (select id from qol_act))
		returning id
),
newqg2avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		(8, 2017, (select id from newqg2), (select id from newqg2act), (select id from qol_avail))
),
newqg1 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Vacation', (select id from qol_goals), 1)
		returning id
),
newqg1act as (
	insert into spendcat_act
		(id, month, year, spendcat_id, catgroup_act_id)
	values
		(default, 8, 2017, (select id from newqg1), (select id from qol_act))
		returning id
),
newqg1avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		(8, 2017, (select id from newqg1), (select id from newqg1act), (select id from qol_avail))
)
select * from qol_goals;



-- Just for Fun 
with just_fun as (
	insert into catgroups
		(id, name, budget_id)
	values
		(DEFAULT, 'Just For Fun', 1)
	returning id
),
fun_act as (
	insert into catgroup_act
		(month, year, catgroup_id)
	values
		(8, 2017, (select id from just_fun))
	returning id
),
fun_avail as (
	insert into catgroup_avail
		(month, year, catgroup_id, catgroup_act_id)
	values
		(8, 2017, (select id from just_fun), (select id from fun_act))
	returning id
),
newjf4 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Fun Money', (select id from just_fun), 1)
		returning id
),
newjf4act as (
	insert into spendcat_act
		(id, month, year, spendcat_id, catgroup_act_id)
	values
		(default,8, 2017, (select id from newjf4), (select id from fun_act))
		returning id
),
newjf4avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		(8, 2017, (select id from newjf4), (select id from newjf4act), (select id from fun_avail))
),
newjf3 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Music',  (select id from just_fun), 1)
		returning id
),
newjf3act as (
	insert into spendcat_act
		(id, month, year, spendcat_id, catgroup_act_id)
	values
		(default,8, 2017, (select id from newjf3), (select id from fun_act))
		returning id
),
newjf3avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		(8, 2017, (select id from newjf3), (select id from newjf3act), (select id from fun_avail))
),
newjf2 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Gaming', (select id from just_fun), 1)
		returning id
),
newjf2act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default,8, 2017, (select id from newjf2), (select id from fun_act))
		returning id
),
newjf2avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		(8, 2017, (select id from newjf2), (select id from newjf2act), (select id from fun_avail))
),
newjf1 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Dining Out', (select id from just_fun), 1)
		returning id
),
newjf1act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default,8, 2017, (select id from newjf1), (select id from fun_act))
		returning id
),
newjf1avail as (
	insert into spendcat_avail
		(month, year,spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		(8, 2017, (select id from newjf1), (select id from newjf1act), (select id from fun_avail))
)
select * from just_fun;

      

-- Insert previous month to calculate current month available
insert into catgroup_act
(month, year, catgroup_id)
select 7, 2017, catgroup_id from catgroup_act
except
select month, year, catgroup_id from catgroup_act;

insert into catgroup_avail
(month, year, catgroup_id, catgroup_act_id)
select 7, 2017, catgroup_id, catgroup_act_id from catgroup_avail
except
select month, year, catgroup_id, catgroup_act_id from catgroup_avail;

insert into spendcat_act
(month, year, spendcat_id, catgroup_act_id)
select 7, 2017, spendcat_id, catgroup_act_id from spendcat_act
except
select month, year, spendcat_id, catgroup_act_id from spendcat_act;

insert into spendcat_avail
(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
select 7, 2017, spendcat_id, spendcat_act_id, catgroup_avail_id from spendcat_avail
except
select month, year, spendcat_id, spendcat_act_id, catgroup_avail_id from spendcat_avail;



-- update
--     accounts
-- set
--     amount = (select sum(outflow) + sum(inflow) from transactions where account_id = accounts.id)
-- where budget_id = 1;



-- -- Insert sample inflow
-- insert into transactions
-- 	(account_id, trans_date, payee_id, spend_cat_id, memo, outflow, inflow, budget_id, type, month, year)
-- values
-- 	(1, '2017-08-08', 1, 1, null, 0, 5432.10, 1, 'inflow', 8, 2017),
-- 	(2, '2017-08-17', 1, 2, null, -500, 0, 1, 'general', 8, 2017),
-- 	(1, '2017-08-20', 1, 2, null, -50, 0, 1, 'general', 8, 2017),
-- 	(3, '2017-09-20', 1, 2, null, -250, 0, 1, 'general', 9, 2017),
-- 	(3, '2017-10-20', 1, 2, null, -75, 0, 1, 'general', 9, 2017);

-- update
--     accounts
-- set
--     amount = (select sum(outflow) + sum(inflow) from transactions)
-- where budget_id = 1 and id = 1;

-- update 
-- 	budgets
-- set
-- 	to_be_budgeted = to_be_budgeted + 0 + 5432.10
-- where id = 1;


-- update
-- 	spendcat_avail sa
-- set 
-- 	available = available + (
-- 		select sum(budgeted) + sum(activity) from spendcat_act 
-- 		where spendcat_id = sa.spendcat_id
-- 	);

-- update catgroup_act cm
-- 	set budgeted = (select sum(budgeted) from spendcat_act sm where sm.catgroup_act_id = cm.id),
-- 		activity = (select sum(activity) from spendcat_act sm where sm.catgroup_act_id = cm.id);

-- update 
-- 	catgroup_avail ca
-- set 
-- 	available = (
-- 		select sum(budgeted) + sum(activity) from catgroup_act
-- 		where catgroup_id = ca.catgroup_id
-- 	);


