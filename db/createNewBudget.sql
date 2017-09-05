with new_budget as (
	insert into budgets
		(id, user_id, name)
	values
		(default, $1, $2)
	returning id
),

-- Inflow Seed
inflow_categories as (
	insert into catgroups
		(id, name, budget_id)
	values
		(DEFAULT, 'Inflow', (select id from new_budget))
	returning id
),
inflow_act as (
	insert into catgroup_act
		(id, month, year, catgroup_id)
	values
		(default, $3, $4, (select id from inflow_categories))
	returning id
),
inflow_avail as (
	insert into catgroup_avail
		(month, year,catgroup_id, catgroup_act_id)
	values
		($3, $4, (select id from inflow_categories), (select id from inflow_act))
	returning id
),
new_inflow as (
	insert into spendcats
		(id, name, type, catgroup_id, budget_id)
	values
		(default, 'Inflow: to be budgeted...', 'inflow', (select id from inflow_categories), (select id from new_budget))
	returning id
),
new_inflow_act as (
	insert into spendcat_act
		(id, month, year, spendcat_id, catgroup_act_id)
	values
		(default, $3, $4, (select id from new_inflow), (select id from inflow_act))
	returning id
),
new_inflow_avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		($3, $4, (select id from new_inflow), (select id from new_inflow_act), (select id from inflow_avail))
),

-- Immediate Obligations Seed
immediate_obs as (
	insert into catgroups
		(id, name, budget_id)
	values
		(DEFAULT, 'Immediate Obligations', (select id from new_budget))
	returning id
),
immediate_obsact as (
	insert into catgroup_act
		(id, month, year, catgroup_id)
	values
		(default, $3, $4, (select id from immediate_obs))
	returning id
),
io_avail as (
	insert into catgroup_avail
		(month, year, catgroup_id, catgroup_act_id)
	values
		($3, $4, (select id from immediate_obs), (select id from immediate_obsact))
	returning id
),
newio8 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Interest & Fees', (select id from immediate_obs), (select id from new_budget))
		returning id
),
newio8act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default,$3, $4, (select id from newio8), (select id from immediate_obsact))
		returning id
),
newio8avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		($3, $4, (select id from newio8), (select id from newio8act), (select id from io_avail))
),
newio7 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Transportation', (select id from immediate_obs), (select id from new_budget))
		returning id
),
newio7act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default,$3, $4, (select id from newio7), (select id from immediate_obsact))
		returning id
),
newio7avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		($3, $4, (select id from newio7), (select id from newio7act), (select id from io_avail))
),
newio6 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Groceries', (select id from immediate_obs), (select id from new_budget))
		returning id
),
newio6act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default, $3, $4, (select id from newio6), (select id from immediate_obsact))
		returning id
),
newio6avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		($3, $4, (select id from newio6), (select id from newio6act), (select id from io_avail))
),
newio5 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Electric', (select id from immediate_obs), (select id from new_budget))
		returning id
),
newio5act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default, $3, $4, (select id from newio5), (select id from immediate_obsact))
		returning id
),
newio5avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		($3, $4, (select id from newio5), (select id from newio5act), (select id from io_avail))
),
newio4 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Internet', (select id from immediate_obs), (select id from new_budget))
		returning id
),
newio4act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default,$3, $4, (select id from newio4), (select id from immediate_obsact))
		returning id
),
newio4avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		($3, $4, (select id from newio4), (select id from newio4act), (select id from io_avail))
),
newio3 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Water', (select id from immediate_obs), (select id from new_budget))
		returning id
),
newio3act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default,$3, $4, (select id from newio3), (select id from immediate_obsact))
		returning id
),
newio3avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		($3, $4, (select id from newio3), (select id from newio3act), (select id from io_avail))
),
newio2 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Electric', (select id from immediate_obs), (select id from new_budget))
		returning id
),
newio2act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default,$3, $4, (select id from newio2), (select id from immediate_obsact))
		returning id
),
newio2avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		($3, $4, (select id from newio2), (select id from newio2act), (select id from io_avail))
),
newio1 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Rent/Mortgage', (select id from immediate_obs), (select id from new_budget))
		returning id
),
newio1act as (
	insert into spendcat_act
		(id, month, year, spendcat_id, catgroup_act_id)
	values
		(default, $3, $4, (select id from newio1), (select id from immediate_obsact))
		returning id
),
newio1avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		($3, $4, (select id from newio1), (select id from newio1act), (select id from io_avail))
),




-- True expenses seed
true_expenses as (
	insert into catgroups
		(id, name, budget_id)
	values
		(DEFAULT, 'True Expenses', (select id from new_budget))
	returning id
),
texpens_act as (
	insert into catgroup_act
		(month, year, catgroup_id)
	values
		($3, $4, (select id from true_expenses))
	returning id
),
expense_avail as (
	insert into catgroup_avail
		(month, year, catgroup_id, catgroup_act_id)
	values
		($3, $4,(select id from true_expenses), (select id from texpens_act))
	returning id
),
newte10 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Stuff I Forgot To Budget For', (select id from true_expenses), (select id from new_budget))
	returning id
),
newte10act as (
	insert into spendcat_act
		(id, month, year, spendcat_id, catgroup_act_id)
	values
		(default,$3, $4,  (select id from newte10), (select id from texpens_act))
	returning id
),
newte10avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		($3, $4,(select id from newte10), (select id from newte10act), (select id from expense_avail))
),
newte9 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Software Subscriptions', (select id from true_expenses), (select id from new_budget))
		returning id
),
newte9act as (
	insert into spendcat_act
		(id, month, year, spendcat_id, catgroup_act_id)
	values
		(default,$3, $4, (select id from newte9), (select id from texpens_act))
	returning id
),
newte9avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		($3, $4, (select id from newte9), (select id from newte9act), (select id from expense_avail))
),
newte8 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Computer Replacement', (select id from true_expenses), (select id from new_budget))
		returning id
),
newte8act as (
	insert into spendcat_act
		(id, month, year, spendcat_id, catgroup_act_id)
	values
		(default,$3, $4, (select id from newte8), (select id from texpens_act))
	returning id
),
newte8avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		($3, $4, (select id from newte8), (select id from newte8act), (select id from expense_avail))
),
newte7 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Giving', (select id from true_expenses), (select id from new_budget))
		returning id
),
newte7act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default,$3, $4, (select id from newte7), (select id from texpens_act))
		returning id
),
newte7avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		($3, $4, (select id from newte7), (select id from newte7act), (select id from expense_avail))
),
newte6 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Gifts',(select id from true_expenses), (select id from new_budget))
		returning id
),
newte6act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default,$3, $4, (select id from newte6), (select id from texpens_act))
		returning id
),
newte6avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		($3, $4, (select id from newte6), (select id from newte6act), (select id from expense_avail))
),
newte5 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Clothing', (select id from true_expenses), (select id from new_budget))
		returning id
),
newte5act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default,$3, $4, (select id from newte5), (select id from texpens_act))
		returning id
),
newte5avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		($3, $4, (select id from newte5), (select id from newte5act), (select id from expense_avail))
),
newte4 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Medical', (select id from true_expenses), (select id from new_budget))
		returning id
),
newte4act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default,$3, $4, (select id from newte4), (select id from texpens_act))
	returning id 
),
newte4avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		($3, $4, (select id from newte4), (select id from newte4act), (select id from expense_avail))
),
newte3 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Renters/Home Insurance', (select id from true_expenses), (select id from new_budget))
		returning id
),
newte3act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default,$3, $4, (select id from newte3), (select id from texpens_act))
	returning id 
),
newte3avail as (
	insert into spendcat_avail
		(month, year,spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		($3, $4,(select id from newte3), (select id from newte3act), (select id from expense_avail))
),
newte2 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
	 	(default, 'Home Maintenance', (select id from true_expenses), (select id from new_budget))
		returning id
),
newte2act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default,$3, $4, (select id from newte2), (select id from texpens_act))
	returning id 
),
newte2avail as (
	insert into spendcat_avail
		(month, year,spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		($3, $4,(select id from newte2), (select id from newte2act), (select id from expense_avail))
),
newte1 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Auto Maintenance', (select id from true_expenses), (select id from new_budget))
		returning id
),
newte1act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default, $3, $4, (select id from newte1), (select id from texpens_act))
		returning id
),
newte1avail as (
	insert into spendcat_avail
		(month, year,spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		($3, $4, (select id from newte1), (select id from newte1act), (select id from expense_avail))
),




debt_payments as (
	insert into catgroups
		(id, name, budget_id)
	values
		(DEFAULT, 'Debt Payments', (select id from new_budget))
	returning id
),
dpay_act as (
	insert into catgroup_act
		(month, year, catgroup_id)
	values
		($3, $4, (select id from debt_payments))
	returning id
),
dpay_avail as (
	insert into catgroup_avail
		(month, year, catgroup_id, catgroup_act_id)
	values
		($3, $4, (select id from debt_payments), (select id from dpay_act))
	returning id
),
newdp2 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default,'Auto Loan', (select id from debt_payments), (select id from new_budget))
		returning id
),
newdp2act as (
	insert into spendcat_act
		(id, month, year, spendcat_id, catgroup_act_id)
	values
		(default, $3, $4, (select id from newdp2), (select id from dpay_act))
		returning id
),
newdp2avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
	($3, $4, (select id from newdp2), (select id from newdp2act), (select id from dpay_avail))
),
newdp1 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default,'Student Loan',(select id from debt_payments), (select id from new_budget))
		returning id
),
newdp1act as (
	insert into spendcat_act
		(id, month, year, spendcat_id, catgroup_act_id)
	values
		(default, $3, $4,  (select id from newdp1), (select id from dpay_act))
		returning id
),
newdp1avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		($3, $4, (select id from newdp1), (select id from newdp1act), (select id from dpay_avail))
),


-- Quality of Life Goals
qol_goals as (
	insert into catgroups
		(id, name,budget_id)
	values
		(DEFAULT, 'Quality of Life Goals', (select id from new_budget))
	returning id
),
qol_act as (
	insert into catgroup_act
		(month, year, catgroup_id)
	values
		($3, $4, (select id from qol_goals))
	returning id
),
qol_avail as (
	insert into catgroup_avail
		(month, year, catgroup_id, catgroup_act_id)
	values
		($3, $4, (select id from qol_goals), (select id from qol_act))
	returning id
),
newqg2 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Fitness', (select id from qol_goals), (select id from new_budget))
		returning id
),
newqg2act as (
	insert into spendcat_act
		(id, month, year, spendcat_id, catgroup_act_id)
	values
		(default, $3, $4, (select id from newqg2), (select id from qol_act))
		returning id
),
newqg2avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		($3, $4, (select id from newqg2), (select id from newqg2act), (select id from qol_avail))
),
newqg1 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Vacation', (select id from qol_goals), (select id from new_budget))
		returning id
),
newqg1act as (
	insert into spendcat_act
		(id, month, year, spendcat_id, catgroup_act_id)
	values
		(default, $3, $4, (select id from newqg1), (select id from qol_act))
		returning id
),
newqg1avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		($3, $4, (select id from newqg1), (select id from newqg1act), (select id from qol_avail))
),



-- Just for Fun 
just_fun as (
	insert into catgroups
		(id, name, budget_id)
	values
		(DEFAULT, 'Just For Fun', (select id from new_budget))
	returning id
),
fun_act as (
	insert into catgroup_act
		(month, year, catgroup_id)
	values
		($3, $4, (select id from just_fun))
	returning id
),
fun_avail as (
	insert into catgroup_avail
		(month, year, catgroup_id, catgroup_act_id)
	values
		($3, $4, (select id from just_fun), (select id from fun_act))
	returning id
),
newjf4 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Fun Money', (select id from just_fun), (select id from new_budget))
		returning id
),
newjf4act as (
	insert into spendcat_act
		(id, month, year, spendcat_id, catgroup_act_id)
	values
		(default,$3, $4, (select id from newjf4), (select id from fun_act))
		returning id
),
newjf4avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		($3, $4, (select id from newjf4), (select id from newjf4act), (select id from fun_avail))
),
newjf3 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Music',  (select id from just_fun), (select id from new_budget))
		returning id
),
newjf3act as (
	insert into spendcat_act
		(id, month, year, spendcat_id, catgroup_act_id)
	values
		(default,$3, $4, (select id from newjf3), (select id from fun_act))
		returning id
),
newjf3avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		($3, $4, (select id from newjf3), (select id from newjf3act), (select id from fun_avail))
),
newjf2 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Gaming', (select id from just_fun), (select id from new_budget))
		returning id
),
newjf2act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default,$3, $4, (select id from newjf2), (select id from fun_act))
		returning id
),
newjf2avail as (
	insert into spendcat_avail
		(month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		($3, $4, (select id from newjf2), (select id from newjf2act), (select id from fun_avail))
),
newjf1 as (
	insert into spendcats
		(id, name, catgroup_id, budget_id)
	values
		(default, 'Dining Out', (select id from just_fun), (select id from new_budget))
		returning id
),
newjf1act as (
	insert into spendcat_act
		(id,month, year, spendcat_id, catgroup_act_id)
	values
		(default,$3, $4, (select id from newjf1), (select id from fun_act))
		returning id
),
newjf1avail as (
	insert into spendcat_avail
		(month, year,spendcat_id, spendcat_act_id, catgroup_avail_id)
	values
		($3, $4, (select id from newjf1), (select id from newjf1act), (select id from fun_avail))
)
insert into Payees 
(name, budget_id)
values
('Starting Balance', (select id from new_budget));

-- Insert previous month to calculate current month available
-- insert into catgroup_act
-- (month, year, catgroup_id)
-- select $3-1, $4, catgroup_id from catgroup_act
-- except
-- select month, year, catgroup_id from catgroup_act;

-- insert into catgroup_avail
-- (month, year, catgroup_id, catgroup_act_id)
-- select  $3-1, $4, catgroup_id, catgroup_act_id from catgroup_avail
-- except
-- select month, year, catgroup_id, catgroup_act_id from catgroup_avail;

-- insert into spendcat_act
-- (month, year, spendcat_id, catgroup_act_id)
-- select  $3-1, $4, spendcat_id, catgroup_act_id from spendcat_act
-- except
-- select month, year, spendcat_id, catgroup_act_id from spendcat_act;

-- insert into spendcat_avail
-- (month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
-- select  $3-1, $4, spendcat_id, spendcat_act_id, catgroup_avail_id from spendcat_avail
-- except
-- select month, year, spendcat_id, spendcat_act_id, catgroup_avail_id from spendcat_avail;

