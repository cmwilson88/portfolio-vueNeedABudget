select t.id id, t.trans_date date, t.account_id, a.name account, a.id, p.name payee, p.id, s.name category, s.id, s.type, t.type, t.memo memo, t.outflow outflow, t.inflow inflow, t.cleared cleared
from transactions t
join budgets b on t.budget_id = b.id
join accounts a on t.account_id = a.id
join payees p on t.payee_id = p.id
join spendcats s on t.spend_cat_id = s.id
where b.id = $1
order by date desc