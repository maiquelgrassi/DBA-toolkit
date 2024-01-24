-- Return the cluster size and the sizes of the databases on the server, ordered by size descendent.
-- Tested on:
	-- PostgreSQL 16.1, compiled by Visual C++ build 1937, 64-bit
	-- PostgreSQL 16.1 (Debian 16.1-1.pgdg120+1) on x86_64-pc-linux-gnu, compiled by gcc (Debian 12.2.0-14) 12.2.0, 64-bit
-- Note: Theoretically, you can use it with all versions above 10. However, I haven't tested it with all of them.
-- Created by: Maiquel O. Grassi

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
