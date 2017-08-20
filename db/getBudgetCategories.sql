select row_to_json(t) as budgetgroup
from (
    select c.id, name, cg.budgeted budgeted, cg.activity activity, 
    (
        select array_to_json(array_agg(row_to_json(d)))
        from (
            select 
                sc.id id, sc.name, type, sm.month, sm.year, sm.budgeted, sm.activity, sa.available
            from spendcats sc
            join spendcat_act sm on sm.spendcat_id = sc.id
            join spendcat_avail sa on sa.spendcat_id = sc.id
            where sc.catgroup_id = c.id 
                and  sm.month = $2 and sm.year = $3
            order by sc.id
        ) d
    ) as subcategories
    from catgroups c
    join catgroup_act cg on cg.catgroup_id = c.id
    where budget_id = $1 
        and cg.month = $2 and cg.year = $3
    order by id
) t;

insert into catgroup_act
(month, year, catgroup_id)
select $2 + 1, 2017, catgroup_id from catgroup_act;

insert into spendcat_act
(month, year, spendcat_id, catgroup_act_id)
select $2 + 1, 2017, spendcat_id, catgroup_act_id from spendcat_act;