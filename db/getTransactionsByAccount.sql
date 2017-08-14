select t.trans_date date, a.name account, p.name payee, s.name category, t.memo, t.outflow, t.inflow, t.cleared 
from transactions t
join budgets b on t.budget_id = b.id
join accounts a on t.account_id = a.id
join payees p on t.payee_id = p.id
join spendcats s on t.spend_cat_id = s.id
where b.id = $1 and t.account_id = $2
order by date desc