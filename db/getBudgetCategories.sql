select row_to_json(t) as budgetgroup
from (
    select c.id, name, 
        (select cg.budgeted budgeted from catgroup_act cg where cg.catgroup_id = c.id and cg.month = $2 and cg.year = $3),
        (select cg.activity activity from catgroup_act cg where cg.catgroup_id = c.id and cg.month = $2 and cg.year = $3),
        (select cg.id catgroup_act_id from catgroup_act cg where cg.catgroup_id = c.id and cg.month = $2 and cg.year = $3),
        (select ca.available available from catgroup_avail ca where ca.catgroup_id = c.id and ca.month = $2 and ca.year = $3), 
    (
        select array_to_json(array_agg(row_to_json(d)))
        from (
            select 
                s.id id, s.name, type, s.catgroup_id catgroup_id,
                (select sg.id spendcat_act_id from spendcat_act sg where sg.spendcat_id = s.id and sg.month = $2 and sg.year = $3),
                (select sg.month from spendcat_act sg where sg.spendcat_id = s.id and sg.month = $2 and sg.year = $3),
                (select sg.year from spendcat_act sg where sg.spendcat_id = s.id and sg.month = $2 and sg.year = $3), 
                (select sg.budgeted from spendcat_act sg where sg.spendcat_id = s.id and sg.month = $2 and sg.year = $3), 
                (select sg.activity from spendcat_act sg where sg.spendcat_id = s.id and sg.month = $2 and sg.year = $3),
                (select sa.available from spendcat_avail sa where sa.spendcat_id = s.id and sa.month = $2 and sa.year = $3),
                (select cg.id catgroup_act_id from catgroup_act cg where cg.catgroup_id = s.catgroup_id and cg.month = $2 and cg.year = $3),
                (select ca.id catgroup_avail_id from catgroup_avail ca where ca.catgroup_id = s.catgroup_id and ca.month = $2 and ca.year = $3) 
            from spendcats s
            where s.catgroup_id = c.id 
            order by s.id
        ) d
    ) as subcategories
    from catgroups c
    where budget_id = $1 
    order by c.id desc
) t;

do $$
begin
IF $2 = 12 THEN

    insert into catgroup_act
    (month, year, catgroup_id)
    select
    1, $3 + 1, catgroup_id from catgroup_act
    except
    select month, year, catgroup_id from catgroup_act;

    insert into spendcat_act
    (month, year, spendcat_id)
    select
    1, $3 + 1, spendcat_id from spendcat_act
    except
    select month, year, spendcat_id from spendcat_act;

    insert into catgroup_avail
    (month, year, catgroup_id, catgroup_act_id)
    select  1, $3 + 1, catgroup_id, catgroup_act_id from catgroup_avail
    except
    select month, year, catgroup_id, catgroup_act_id from catgroup_avail;


    insert into spendcat_avail
    (month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
    select 1, $3 + 1, spendcat_id, spendcat_act_id, catgroup_avail_id from spendcat_avail
    except
    select month, year, spendcat_id, spendcat_act_id, catgroup_avail_id from spendcat_avail;

ELSE 

    insert into catgroup_act
    (month, year, catgroup_id)
    select
    $2 + 1, $3, catgroup_id from catgroup_act
    except
    select month, year, catgroup_id from catgroup_act;

    insert into spendcat_act
    (month, year, spendcat_id)
    select
    $2 + 1, $3, spendcat_id from spendcat_act
    except
    select month, year, spendcat_id from spendcat_act;

    insert into catgroup_avail
    (month, year, catgroup_id, catgroup_act_id)
    select  $2 + 1, $3, catgroup_id, catgroup_act_id from catgroup_avail
    except
    select month, year, catgroup_id, catgroup_act_id from catgroup_avail;


    insert into spendcat_avail
    (month, year, spendcat_id, spendcat_act_id, catgroup_avail_id)
    select $2 + 1, $3, spendcat_id, spendcat_act_id, catgroup_avail_id from spendcat_avail
    except
    select month, year, spendcat_id, spendcat_act_id, catgroup_avail_id from spendcat_avail;

END IF;
end
$$;
