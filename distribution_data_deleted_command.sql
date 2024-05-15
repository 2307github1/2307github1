
use distribution


select * from MSrepl_errors order by id desc



select * from MSrepl_commands where xact_seqno = 0x0000938F00012C80000300000000 and command_id =1

select * from MSrepl_commands where xact_seqno  =0x0000938F0000F470000300000000 and command_id =1

exec sp_browsereplcmds
@xact_seqno_start ='0x0000938F00012C800003',
@xact_seqno_end= '0x0000938F00012C800003',
@publisher_database_id=7,
@article_id=1,
@command_id=1


delete from MSrepl_commands where xact_seqno = 0x0000938F00012C800003
and command_id =1