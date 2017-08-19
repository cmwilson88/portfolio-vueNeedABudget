with new_account as (
    insert into accounts 
    (id, name, type, amount, budget_id)
    values
    (DEFAULT, $1, $2, $3, $4)
    returning id, amount
)
insert into transactions
(account_id, trans_date, payee_id, spend_cat_id, memo, outflow, inflow, budget_id, type)
values
((select id from new_account), current_timestamp, 1, 1, null, 0, $3, $4, 'inflow');

update budgets
set	to_be_budgeted = (select sum(inflow) from transactions where transactions.type = 'inflow' and budget_id = $4) - (select sum(budgeted) from catgroups where budget_id = $4)
where id = $4