update 
	transactions
set
	account_id = $1,
	trans_date = $2, 
	payee_id = $3, 
	spend_cat_id = $4,
	memo = $5, 
	outflow = $6, 
	inflow = $7,  
	type = $9
where id = $10;

update
    accounts
set
    amount = (select sum(outflow) + sum(inflow) from transactions where account_id = accounts.id)
where budget_id = $8;

update
	spendcats
set
	activity = activity + (select sum(outflow) + sum(inflow) from transactions where spend_cat_id = spendcats.id)
where id = $4;

update
	spendcats
set
	available = budgeted + activity;

update catgroups
set
    budgeted = (select sum(budgeted) from spendcats where catgroup_id = catgroups.id),
        activity = (select sum(activity) from spendcats where catgroup_id = catgroups.id),
        available = (select sum(available) from spendcats where catgroup_id = catgroups.id);

update 
	budgets
set
	to_be_budgeted = (select sum(inflow) from transactions where transactions.type = 'inflow' and budget_id = $8) - (select sum(budgeted) from catgroups where budget_id = $8)
where id = $8