with new_spendcat as (
	insert into spendcats
		(id, name, catgroup_id, budget_id) 
	values
		(DEFAULT, $1, $2, $3)
	returning id
),
new_spendcat_act as (
	insert into spendcat_act
		(id, month, year, spendcat_id, catgroup_act_id)
	values
		(default, $4, $5, (select id from new_spendcat), $6)
	returning id
)
insert into spendcat_avail
	(spendcat_id, spendcat_act_id)
values
	((select id from new_spendcat), (select id from new_spendcat_act))