select a.id, a.name, a.type, a.amount from accounts a 
join budgets b on a.budget_id = b.id
where a.budget_id = $1
order by a.id