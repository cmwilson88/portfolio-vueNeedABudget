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

-- Update current month spending category availability based on previous month
-- If month is January, set previous month to 12 and previous year to current year minus one
do $$
begin
IF $10 = 1 THEN
	update spendcat_avail sa
	set available = (select coalesce((select available from spendcat_avail where month = 12 and year = $11 - 1 and spendcat_id = $4), 0) + (select budgeted + activity from spendcat_act where month = $10 and spendcat_id = $4))
	where spendcat_id = $4 and month = $10;
ELSE 
	update spendcat_avail sa
	set available = (select coalesce((select available from spendcat_avail where month = $10-1 and spendcat_id = $4), 0) + (select budgeted + activity from spendcat_act where month = $10 and spendcat_id = $4))
	where spendcat_id = $4 and month = $10;
END IF;
end
$$;

-- Update next month spending category availability
-- If month is December, set next month to 1 and next year to $11 + 1
do $$
begin
IF $10 = 12 THEN
	update spendcat_avail
	set available = (select coalesce((select available from spendcat_avail where spendcat_id = $4 and month = $10 and year = $11),0) + (select sum(budgeted) + sum(activity) from spendcat_act where spendcat_id = $4 and month = 1 and year = $11+1))
	where spendcat_id = $4 and month = 1 and year = $11+1;
ELSE 
	update spendcat_avail
	set available = (select coalesce((select available from spendcat_avail where spendcat_id = $4 and month = $10 and year = $11),0) + (select sum(budgeted) + sum(activity) from spendcat_act where spendcat_id = $4 and month = $10+1 and year = $11))
	where spendcat_id = $4 and month = $10+1 and year = $11;
END IF;
end 
$$;

update catgroup_act  
	set activity = (
			select sum(sg.activity) from spendcat_act sg
			join spendcats s on sg.spendcat_id = s.id
			join catgroups c on c.id = s.catgroup_id
			join catgroup_act cg on c.id = cg.catgroup_id
			where sg.month = $10 and sg.year = $11
			and cg.id = $12
		)
	where catgroup_id = $13 and month = $10 and year = $11;


update catgroup_avail
	set available = (
			select sum(available) from spendcat_avail sa
			join spendcats s on sa.spendcat_id = s.id
			join catgroups c on c.id = s.catgroup_id
			where month = $10 and year = $11
			and catgroup_id = $13
		)
	where catgroup_id = $13 and month = $10 and year = $11;

-- Update category group availability for the follwoing month
-- If month is december, manually update 1st month of year+1 else update month+1 of current year
do $$
begin 
IF $10 = 12 THEN
	update catgroup_avail
		set available = (
				select sum(available) from spendcat_avail sa
				join spendcats s on sa.spendcat_id = s.id
				join catgroups c on c.id = s.catgroup_id
				where month = 1 and year = $11+1
				and catgroup_id = $13
			)
		where catgroup_id = $13 and month = 1 and year = $11+1;
ELSE
	update catgroup_avail
	set available = (
			select sum(available) from spendcat_avail sa
			join spendcats s on sa.spendcat_id = s.id
			join catgroups c on c.id = s.catgroup_id
			where month = $10+1 and year = $11
			and catgroup_id = $13
		)
	where catgroup_id = $13 and month = $10+1 and year = $11;
END IF;
end
$$;


update 
	budgets
set	
	to_be_budgeted = (
		select coalesce((select sum(inflow) 
		from transactions 
		where transactions.type = 'inflow' 
		and budget_id = $8
		), 0) - (
		select sum(cg.budgeted) from catgroups c
		join catgroup_act cg on cg.catgroup_id = c.id 
		where budget_id = $8
		))
where id = $8

