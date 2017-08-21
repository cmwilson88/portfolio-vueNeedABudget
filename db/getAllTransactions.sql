select t.id id, t.trans_date date, t.month trans_month, t.year trans_year, t.account_id, a.name account, a.id account_id, p.name payee, p.id payee_id, s.name category, s.id spend_cat_id, s.type spend_type, t.type trans_type, t.memo memo, t.outflow outflow, t.inflow inflow, t.cleared cleared, t.catgroup_act_id catgroup_act_id
from transactions t
join budgets b on t.budget_id = b.id
join accounts a on t.account_id = a.id
join payees p on t.payee_id = p.id
join spendcats s on t.spend_cat_id = s.id
where b.id = $1
order by date desc