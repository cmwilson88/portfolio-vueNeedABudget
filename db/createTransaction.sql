insert into transactions
	(account_id, trans_date, payee_id, spend_cat_id, memo, outflow, inflow, budget_id)
values
	($1, $2, $3, $4, $5, $6, $7, $8);

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