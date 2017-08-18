select p.id, p.name, p.budget_id from payees p 
join budgets b on b.id = p.budget_id
where b.id = $1