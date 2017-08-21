with new_catGroup as (
	insert into catgroups
		(id, name, budget_id)
	values
		(DEFAULT, $1, $2)
	returning id
),
new_group_act as (
	insert into catgroup_act
		(id, month, year, catgroup_id)
	values
		(default, $3, $4, (select id from new_catGroup))
	returning id
)
insert into catgroup_avail
	(catgroup_id, catgroup_act_id)
values
	((select id from new_catGroup), (select id from new_group_act))