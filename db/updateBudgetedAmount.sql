update 
	spendcats
set 
	budgeted = $1
where id = $2;

update 
	spendcats
set 
	available = budgeted + activity
where id = $2;

update
	budgets
set
	to_be_budgeted = to_be_budgeted - $1
where id = $3;


update 
	catgroups
set
    budgeted = (select sum(budgeted) from spendcats where catgroup_id = catgroups.id),
        activity = (select sum(activity) from spendcats where catgroup_id = catgroups.id),
        available = (select sum(available) from spendcats where catgroup_id = catgroups.id);