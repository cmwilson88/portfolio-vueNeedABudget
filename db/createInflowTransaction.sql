insert into transactions
(account_id, trans_date, payee_id, spend_cat_id, memo, outflow, inflow, budget_id)
values
((select id from new_account), '2017-8-8', 1, 1, null, 0, $3, $4);