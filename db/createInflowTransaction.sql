insert into transactions
	(id, account_id, trans_date, payee_id, spend_cat_id, memo, outflow, inflow, budget_id, type, month, year, catgroup_act_id)
values
	(default,$1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12);

update
    accounts
set
    amount = (select sum(outflow) + sum(inflow) from transactions where account_id = accounts.id)
where budget_id = $8;

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