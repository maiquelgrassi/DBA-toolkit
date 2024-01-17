-- Return the cluster size and the sizes of the databases on the server, ordered by size descendente.
SELECT
	'-' AS "RANKING"
	,'CLUSTER (total)' AS "DATABASE" 
	,pg_size_pretty(sum(pg_database_size(datname))) AS "SIZE"
	,to_char(current_date,'DD/MM/YYYY') AS "QUERY DATE"
	,to_char(localtime,'HH24:MI:SS')::text AS "QUERY TIME"
FROM
	pg_catalog.pg_database
UNION ALL
SELECT
	 row_number() over()::text
	,db
	,pg_size_pretty(sz)
	,dt
	,hr
FROM
(
	SELECT
	 	 datname AS db
		,pg_database_size(datname) AS sz
		,to_char(current_date,'DD/MM/YYYY') AS dt
		,to_char(localtime,'HH24:MI:SS')::text AS hr
	FROM
		 pg_catalog.pg_database
	ORDER BY
		 sz DESC
) subquery;
