 create database WorldCup
 
 create table teams (
      team_id integer not null,
      team_name varchar(30) not null,
      unique(team_id)
  );

    create table matches (
      match_id integer not null,
      host_team integer not null,
      guest_team integer not null,
      host_goals integer not null,
      guest_goals integer not null,
      unique(match_id)
  );

  --Insertar registros en tabla Teams
   insert into teams values(10,'Give')
   insert into teams values(20,'Never')
   insert into teams values(30,'You')
   insert into teams values(40,'Up')
   insert into teams values(50,'Gonna')

   --Insertar registros en tabla Matches
     insert into matches values(1,30,20,1,0)
	 insert into matches values(2,10,20,1,2)
	 insert into matches values(3,20,50,2,2)
	 insert into matches values(4,10,30,1,0)
	 insert into matches values(5,30,50,0,1)

	 --Select
	 select *from teams
	 select *from matches

	 select team_id, team_name,
	 coalesce (sum(case when team_id = host_team then
	 (
		case when host_goals > guest_goals then 3
		when host_goals = guest_goals then 1
		when host_goals < guest_goals then 0 
		end
	)
	when team_id = guest_team then
	(
		case when guest_goals > host_goals then 3
		when guest_goals = host_goals then 1
		when guest_goals < host_goals then 0 
		end
	)
	end),0) as num_points
	
	from teams
	left join matches
	on
	teams.team_id = matches.host_team
	or teams.team_id = matches.guest_team
	group by team_id, team_name
	order by num_points desc, team_id;

