update 
	spendcat_act
set 
	budgeted = $1
where spendcat_id = $2 and month = $4 and year = $5;

update spendcat_avail sa
set available = (select coalesce((select available from spendcat_avail where month = $4-1 and spendcat_id = $2), 0) + (select budgeted + activity from spendcat_act where month = $4 and spendcat_id = $2))
where spendcat_id = $2 and month = $4 and year = $5;

update spendcat_avail
	set available = (select coalesce((select available from spendcat_avail where spendcat_id = $2 and month = $4 and year = $5),0) + (select sum(budgeted) + sum(activity) from spendcat_act where spendcat_id = $2 and month = $4+1 and year = $5))
where spendcat_id = $2 and month = $4+1 and year = $5;

update 
	budgets
set	
	to_be_budgeted = (
		select coalesce((select sum(inflow) 
		from transactions 
		where transactions.type = 'inflow' 
		and budget_id = $3
		),0) - (
		select sum(sg.budgeted) from spendcats s
		join spendcat_act sg on sg.spendcat_id = s.id 
		where budget_id = $3
		)
	)
where id = $3;

update catgroup_act  
	set budgeted = (
			select sum(budgeted) from spendcat_act
			where month = $4 and year = $5
			and catgroup_act_id = $7
		)
	where catgroup_id = $7 and month = $4 and year = $5;

update catgroup_avail
set available = (select available from catgroup_avail where month = $4-1 and year = $5 and catgroup_id = $6) + (select budgeted + activity from catgroup_act where month = $4 and year = $5 and catgroup_id = $6)
where catgroup_id = $6 and month = $4 and year = $5;

update catgroup_avail
set available = (select available from catgroup_avail where month = $4 and year = $5 and catgroup_id = $6) + (select budgeted + activity from catgroup_act where month = $4+1 and year = $5 and catgroup_id = $6)
where catgroup_id = $6 and month = $4+1 and year = $5;
