USE test;

DROP TABLE IF EXISTS test_log;

create table test_log
(
	created datetime,
	created_month char(6),
	msg varchar(2000)
)
PARTITION BY LIST COLUMNS(created_month)(
	PARTITION p202005 VALUES IN ('202005'),
	PARTITION p202006 VALUES IN ('202006')
);

insert into test_log values('2020-05-01 02:12:05', '202005', 'hi');
insert into test_log values('2020-05-01 04:12:15', '202005', 'ni');
insert into test_log values('2020-06-01 07:14:10', '202006', 'hao');