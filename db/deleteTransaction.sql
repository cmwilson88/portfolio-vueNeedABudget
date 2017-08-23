delete from transactions
	where id = $2;

update
    accounts
set
    amount = (select sum(outflow) + sum(inflow) from transactions where account_id = accounts.id)
where budget_id = $1;

update 
	budgets
set	
	to_be_budgeted = (
		select coalesce((select sum(inflow) 
		from transactions 
		where transactions.type = 'inflow' 
		and budget_id = $1
		),0) - (
		select sum(cg.budgeted) from catgroups c
		join catgroup_act cg on cg.catgroup_id = c.id 
		where budget_id = $1
		))
where id = $1;