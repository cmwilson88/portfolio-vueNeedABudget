insert into transactions
	(account_id, trans_date, payee_id, spend_cat_id, memo, outflow, inflow, budget_id)
values
	($1, $2, $3, $4, $5, $6, $7, $8);

update
    accounts
set
    amount = (select sum(outflow) + sum(inflow) from transactions where account_id = accounts.id)
where budget_id = $8;

update
	spendcats
set
	activity = (select outflow + inflow from transactions where spend_cat_id = spendcats.id)
where id = $4


