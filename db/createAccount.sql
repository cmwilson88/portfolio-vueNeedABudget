with new_account as (
    insert into accounts 
    (id, name, type, amount, budget_id)
    values
    (DEFAULT, $1, $2, $3, $4)
    returning id, amount
)
insert into transactions
	(account_id, trans_date, month, year,
	 payee_id, spend_cat_id, memo, outflow, 
	 inflow, budget_id, type, catgroup_act_id)
values
	((select id from new_account), current_timestamp, date_part('month', current_timestamp), date_part('year', current_timestamp),
	 1, (select id from spendcats where type = 'inflow' and budget_id = $4), null, 0, 
	 $3, $4, 'inflow', 1);

update 
	budgets
set	
	to_be_budgeted = (
		select coalesce((select sum(inflow) 
		from transactions 
		where transactions.type = 'inflow' 
		and budget_id = $4
		),0) - (
		select sum(cg.budgeted) from catgroups c
		join catgroup_act cg on cg.catgroup_id = c.id 
		where budget_id = $4
		))
where id = $4;

