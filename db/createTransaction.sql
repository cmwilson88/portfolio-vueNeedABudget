insert into transactions
	(account_id, trans_date, payee_id, spend_cat_id, memo, outflow, inflow, budget_id)
values
	($1, $2, $3, $4, $5, $6, $7, $8)