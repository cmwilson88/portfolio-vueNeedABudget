with new_account as (
    insert into accounts 
    (id, name, type, amount, budget_id)
    values
    (DEFAULT, $1, $2, $3, $4)
    returning id
)
insert into transactions
(account_id, trans_date, payee_id, spend_cat_id, memo, outflow, inflow, budget_id)
values
((select id from new_account), '2017-8-8', 1, 1, null, 0, $3, $4);