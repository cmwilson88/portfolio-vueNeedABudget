select row_to_json(t) as budgetgroup
from (
    select id, name, budgeted, activity, available,
    (
        select array_to_json(array_agg(row_to_json(d)))
        from (
            select id, name, type, budgeted, activity, available
            from spendcats
            where spendcats.catgroup_id = catgroups.id and month = $2 and year = $3
            order by id
        ) d
    ) as subcategories
    from catgroups
    where budget_id = $1 and month = $2 and year = $3
    order by id
) t