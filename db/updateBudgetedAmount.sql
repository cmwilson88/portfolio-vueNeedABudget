update 
	spendcat_act
set 
	budgeted = $1
where spendcat_id = $2 and month = $4 and year = $5;

-- Update current spendcat_availability based on previous month
-- If current month is january, go to previous december 
do $$
begin
IF $4 = 1 THEN
	update spendcat_avail sa
		set available = (
				select coalesce(
					(select available 
						from spendcat_avail 
						where month = 1 and year = $5 - 1 and spendcat_id = $2)
				,0)
			+ 
				(select budgeted + activity 
					from spendcat_act 
					where month = $4 and spendcat_id = $2)
			)
	where spendcat_id = $2 and month = $4 and year = $5;
ELSE 
	update spendcat_avail sa
		set available = (
				select coalesce(
					(select available 
						from spendcat_avail 
						where month = $4-1 and spendcat_id = $2)
				,0)
			+ 
				(select budgeted + activity 
					from spendcat_act 
					where month = $4 and spendcat_id = $2)
			)
	where spendcat_id = $2 and month = $4 and year = $5;
END IF;
end 
$$;

-- Update next months spendcat_avail 
-- If current month is december, set next month to 1 and year to current year plus one
do $$
begin
IF $4 = 12 THEN
	update spendcat_avail
		set available = (
				select coalesce(
					(select available 
						from spendcat_avail 
						where spendcat_id = $2 and month = $4 and year = $5)
				,0) 
			+ 
				(select sum(budgeted) + sum(activity) 
					from spendcat_act 
					where spendcat_id = $2 and month = 1 and year = $5 + 1))
	where spendcat_id = $2 and month = 1 and year = $5 + 1;
ELSE
update spendcat_avail
	set available = (
			select coalesce(
				(select available 
					from spendcat_avail 
					where spendcat_id = $2 and month = $4 and year = $5)
			,0) 
		+ 
			(select sum(budgeted) + sum(activity) 
				from spendcat_act 
				where spendcat_id = $2 and month = $4+1 and year = $5))
where spendcat_id = $2 and month = $4+1 and year = $5;
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
		and budget_id = $3
		),0) - (
		select sum(sg.budgeted) from spendcats s
		join spendcat_act sg on sg.spendcat_id = s.id 
		where budget_id = $3
		)
	)
where id = $3;

-- Update current month category group activity
--  based on current month spending categority activities
update catgroup_act  
	set budgeted = (
			select sum(sg.budgeted) from spendcat_act sg
			join spendcats s on sg.spendcat_id = s.id
			join catgroups c on c.id = s.catgroup_id
			join catgroup_act cg on c.id = cg.catgroup_id
			where sg.month = $4 and sg.year = $5
			and cg.id = $7
		)
	where catgroup_id = $6 and month = $4 and year = $5;

-- Update current month category group availbility
-- based on current month spending category availablity
update catgroup_avail
	set available = (
			select sum(available) from spendcat_avail sa
			join spendcats s on sa.spendcat_id = s.id
			join catgroups c on c.id = s.catgroup_id
			where month = $4 and year = $5
			and catgroup_id = $6
		)
	where catgroup_id = $6 and month = $4 and year = $5;

-- Update next month category group availability
-- If december, set next month to 1 and year to current month plus one
do $$
begin
IF $4 = 12 THEN
	update catgroup_avail
		set available = (
				select sum(available) from spendcat_avail sa
				join spendcats s on sa.spendcat_id = s.id
				join catgroups c on c.id = s.catgroup_id
				where month = 1 and year = $5 + 1
				and catgroup_id = $6
			)
		where catgroup_id = $6 and month = 1 and year = $5 + 1;
ELSE
	update catgroup_avail
		set available = (
				select sum(available) from spendcat_avail sa
				join spendcats s on sa.spendcat_id = s.id
				join catgroups c on c.id = s.catgroup_id
				where month = $4+1 and year = $5
				and catgroup_id = $6
			)
		where catgroup_id = $6 and month = $4+1 and year = $5;
END IF;
end
$$

