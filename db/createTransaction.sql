insert into transactions
	(account_id, trans_date, payee_id, spend_cat_id, memo, outflow, inflow, budget_id, type, month, year, catgroup_act_id)
values
	($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12);

update
    accounts
set
    amount = (select sum(outflow) + sum(inflow) from transactions where account_id = accounts.id)
where budget_id = $8;

update 
    spendcat_act sg
set
    activity = (
		select sum(outflow) + sum(inflow) from transactions t
		where spend_cat_id = $4
		and month = $10 and year = $11
        )
    where spendcat_id = $4 and month = $10 and year = $11;


update spendcat_avail sa
set available = (select coalesce((select available from spendcat_avail where month = $10-1 and spendcat_id = $4), 0) + (select budgeted + activity from spendcat_act where month = $10 and spendcat_id = $4))
where spendcat_id = $4 and month = $10;

update spendcat_avail
	set available = (select coalesce((select available from spendcat_avail where spendcat_id = $4 and month = $10 and year = $11),0) + (select sum(budgeted) + sum(activity) from spendcat_act where spendcat_id = $4 and month = $10+1 and year = $11))
	where spendcat_id = $4 and month = $10+1 and year = $11;

update catgroup_act  
	set activity = (
			select sum(activity) from spendcat_act
			where month = $10 and year = $11
			and catgroup_act_id = $12
		)
	where catgroup_id = $12 and month = $10 and year = $11;

update catgroup_avail
set available = (select available from catgroup_avail where month = $10-1 and year = $11 and catgroup_id = $12) + (select budgeted + activity from catgroup_act where month = $10 and year = $11 and catgroup_id = $12)
where catgroup_id = $12 and month = $10 and year = $11;

update catgroup_avail
set available = (select available from catgroup_avail where month = $10 and year = $11 and catgroup_id = $12) + (select budgeted + activity from catgroup_act where month = $10+1 and year = $11 and catgroup_id = $12)
where catgroup_id = $12 and month = $10+1 and year = $11;

update 
	budgets
set	
	to_be_budgeted = (
		select sum(inflow) 
		from transactions 
		where transactions.type = 'inflow' 
		and budget_id = $8
		) - (
		select sum(cg.budgeted) from catgroups c
		join catgroup_act cg on cg.catgroup_id = c.id 
		where budget_id = $8
		)
where id = $8

