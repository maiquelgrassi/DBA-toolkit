-- Return:
    -- Do you remember the Linux command 'whoami'? Well, it's like that,
    -- this function returns very important information for the DBA.
-- Tested on:
	-- PostgreSQL 16.1, compiled by Visual C++ build 1937, 64-bit
	-- PostgreSQL 16.1 (Debian 16.1-1.pgdg120+1) on x86_64-pc-linux-gnu, compiled by gcc (Debian 12.2.0-14) 12.2.0, 64-bit
-- Note: Theoretically, you can use it with all versions above 10. However, I haven't tested it with all of them.
-- Created by: Maiquel O. Grassi

CREATE OR REPLACE FUNCTION public.dba_whoami()
RETURNS TABLE ("Current Connection Information" text) AS
$$
BEGIN
	RETURN query SELECT UNNEST
	(
		ARRAY
		[
			'DATABASE: '		||	pg_catalog.current_database()
			,'SCHEMA: '		||	current_schema
			,'USER: '		||	current_user
			,'VERSION: '		||	pg_catalog.current_setting('server_version')
			,'SERVER ADDRESS: '	||	regexp_replace(pg_catalog.inet_server_addr()::text,'/.*','')
			,'SERVER PORT: '	||	pg_catalog.current_setting('port')
			,'CLIENT ADDRESS: '	||	regexp_replace(pg_catalog.inet_client_addr()::text,'/.*','')
			,'CLIENT PORT: '	||	pg_catalog.inet_client_port()::text
			,'PID: '		||	pg_catalog.pg_backend_pid()::text
			,'DATE: '		||	to_char(current_date,'dd/MM/yyyy')
			,'HOUR: '		||	to_char(clock_timestamp(),'HH24:MI:SS.MS')
		]
	);
END;
$$ LANGUAGE plpgsql;

-- How to use:
SELECT * FROM dba_whoami();
-- or
SELECT dba_whoami();
