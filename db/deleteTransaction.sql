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


update 
    spendcat_act sg
set
    activity = (
		select coalesce((select sum(outflow) + sum(inflow)),0)  from transactions t
		where spend_cat_id = $3
		and month = $4 and year = $5
        )
    where spendcat_id = $3 and month = $4 and year = $5;

update spendcat_avail sa
set available = (select coalesce((select available from spendcat_avail where month = $4-1 and spendcat_id = $3), 0) + (select budgeted + activity from spendcat_act where month = $4 and spendcat_id = $3))
where spendcat_id = $3 and month = $4;

update spendcat_avail
	set available = (select coalesce((select available from spendcat_avail where spendcat_id = $3 and month = $4 and year = $5),0) + (select sum(budgeted) + sum(activity) from spendcat_act where spendcat_id = $3 and month = $4+1 and year = $5))
	where spendcat_id = $3 and month = $4+1 and year = $5;


update catgroup_act  
	set activity = (
			select sum(sg.activity) from spendcat_act sg
			join spendcats s on sg.spendcat_id = s.id
			join catgroups c on c.id = s.catgroup_id
			join catgroup_act cg on c.id = cg.catgroup_id
			where sg.month = $4 and sg.year = $5
			and cg.id = $6
		)
	where catgroup_id = $7 and month = $4 and year = $5;


update catgroup_avail
	set available = (
			select sum(available) from spendcat_avail sa
			join spendcats s on sa.spendcat_id = s.id
			join catgroups c on c.id = s.catgroup_id
			where month = $4 and year = $5
			and catgroup_id = $7
		)
	where catgroup_id = $7 and month = $4 and year = $5;

update catgroup_avail
	set available = (
			select sum(available) from spendcat_avail sa
			join spendcats s on sa.spendcat_id = s.id
			join catgroups c on c.id = s.catgroup_id
			where month = $4+1 and year = $5
			and catgroup_id = $7
		)
	where catgroup_id = $7 and month = $4+1 and year = $5;