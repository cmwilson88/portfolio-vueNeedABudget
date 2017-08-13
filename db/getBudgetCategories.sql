select row_to_json(t) as budgetgroup
from (
    select id, name, budgeted, activity, available,
    (
        select array_to_json(array_agg(row_to_json(d)))
        from (
            select id, name, budgeted, activity, available
            from spendcats
            where spendcats.catgroup_id = catgroups.id
        ) d
    ) as subcategories
    from catgroups
    order by id
) t