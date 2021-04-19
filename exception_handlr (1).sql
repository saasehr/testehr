create table log_message
(id number,
 function_name varchar2(255),
 updt_dt_tm date,
 message_type varchar2(30), 
 message varchar2(4000)
 );
 
--
-- Package specification for exception handler
-- 
create or replace package exception_handler as
  procedure log_message(v_fn_name varchar2, v_msg_type in varchar2, v_msg varchar2);
end exception_handler;
 


--
-- Package body for exception handler
-- Call log_message function to log exceptions into log_message table
--
create or replace package body exception_handler as
  procedure log_message(v_fn_name varchar2, v_msg_type in varchar2, v_msg varchar2) 
  is pragma autonomous_transaction;
  begin
   -- insert log message into log table
    insert into log_message(function_name,updt_dt_tm,message_type,message)
	values (v_fn_name,sysdate,v_msg_type,v_msg);
    commit;
  exception 
    when others then
	  null;
  end log_message;
end exception_handler;