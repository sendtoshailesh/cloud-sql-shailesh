admin_shkm_altostrat_com@instance-mumbai:~/alloydb/demo$ pgbench --host=10.45.193.230 --username=postgres -n -c 5 -j 5 -S -T 9000 -f pgbench.sql  testdb

create table t1 (id integer, name varchar(10));

insert into t1 values(100,'ABC');
insert into t1 values(101,'SQL');
insert into t1 values(102,'OPM');
insert into t1 values(103,'UYT');
insert into t1 values(104,'BDE');
insert into t1 values(105,'CBA');

\d t1
select * from t1;

begin;
update t1 set name='UPD';

rr=`echo $RANDOM | md5sum | head -c 9`

nohup psql -h $hh -U postgres testdb -c "update t1 set name='${rr}'" &


===============================================================================================
Sample table with Data
===============================================================================================
CREATE TABLE Departments (code VARCHAR(4), UNIQUE (code));
CREATE TABLE Towns (
  id SERIAL UNIQUE NOT NULL,
  code VARCHAR(10) NOT NULL, -- not unique
  article TEXT,
  name TEXT NOT NULL, -- not unique
  department VARCHAR(4) NOT NULL REFERENCES Departments (code),
  UNIQUE (code, department)
);

To insert one million rows into Towns


insert into towns (code, article, name, department)
select
    left(md5(i::text), 10),
    md5(random()::text),
    md5(random()::text),
    left(md5(random()::text), 4)
from generate_series(1, 1000000) s(i);

CREATE TABLE Towns (
  id SERIAL UNIQUE NOT NULL,
  code VARCHAR(10) NOT NULL,
  article TEXT,
  name TEXT NOT NULL, -- not unique
  department integer NOT NULL
);

insert into towns (code, article, name, department)
select
    left(md5(i::text), 10),
    md5(random()::text),
    md5(random()::text),
    round(random()*1000)
from generate_series(1, 1000000) s(i);

\timing on
select * from towns where department in (select distinct department from towns where department between 150 and 250);

explain select * from towns where department in (select distinct department from towns where department between 150 and 250);

pgbench --host=10.45.193.230 --username=postgres -n -c 2 -j 1 -S -T 9000 -f exp.sql  testdb

create index idx_towns_dept on towns(department);

Since id is a serial it is not necessary to include it.


testdb=> \timing on
Timing is on.
testdb=> select * from towns where department in (select department from towns where department between 150 and 250);
Time: 378.372 ms
testdb=> explain select * from towns where department in (select distinct department from towns where department between 150 and 250);
                                      QUERY PLAN
---------------------------------------------------------------------------------------
 Hash Join  (cost=29565.73..56487.85 rows=1000000 width=85)
   Hash Cond: (towns.department = towns_1.department)
   ->  Seq Scan on towns  (cost=0.00..24286.00 rows=1000000 width=85)
   ->  Hash  (cost=29553.22..29553.22 rows=1001 width=4)
         ->  HashAggregate  (cost=29533.20..29543.21 rows=1001 width=4)
               Group Key: towns_1.department
               ->  Seq Scan on towns towns_1  (cost=0.00..29286.00 rows=98880 width=4)
                     Filter: ((department >= 150) AND (department <= 250))
(8 rows)

Time: 2.132 ms
testdb=> select * from towns where department in (select distinct department from towns where department between 150 and 250);
Time: 384.005 ms
testdb=>
testdb=>
testdb=>
testdb=>
testdb=> create index idx_towns_dept on towns(department);
CREATE INDEX
Time: 1014.358 ms (00:01.014)
testdb=> explain select * from towns where department in (select distinct department from towns where department between 150 and 250);
                                              QUERY PLAN
------------------------------------------------------------------------------------------------------
 Hash Join  (cost=18150.88..45072.99 rows=1000000 width=85)
   Hash Cond: (towns.department = towns_1.department)
   ->  Seq Scan on towns  (cost=0.00..24286.00 rows=1000000 width=85)
   ->  Hash  (cost=18138.36..18138.36 rows=1001 width=4)
         ->  HashAggregate  (cost=18118.35..18128.35 rows=1001 width=4)
               Group Key: towns_1.department
               ->  Bitmap Heap Scan on towns towns_1  (cost=2101.95..17871.15 rows=98880 width=4)
                     Recheck Cond: ((department >= 150) AND (department <= 250))
                     ->  Bitmap Index Scan on idx_towns_dept  (cost=0.00..2077.23 rows=98880 width=0)
                           Index Cond: ((department >= 150) AND (department <= 250))
(10 rows)

Time: 1.586 ms
testdb=>


===============================================================================================





pgbench --host=10.45.193.230 --username=postgres -n -c 5 -j 5 -S -T 9000 -f pgbench.sql  testdb

pgbench --host=10.45.193.230 --username=postgres -n -c 2 -j 2 -S -T 9000 -f pgb1.sql  testdb

pgbench --host=10.45.193.230 --username=postgres -n -c 2 -j 2 -S -T 9000 -f pgb2.sql  testdb

SELECT datname,usename,client_addr,client_port FROM pg_stat_activity ;





admin_shkm_altostrat_com@instance-mumbai:~$ cd alloydb/demo
admin_shkm_altostrat_com@instance-mumbai:~/alloydb/demo$ ls
pgb1.sql  pgb2.sql  pgbench.sql
admin_shkm_altostrat_com@instance-mumbai:~/alloydb/demo$ cat *
select
        l_shipmode, n_nationkey, r_regionkey,
        sum(case
                when o_orderpriority = '1-URGENT'
                        or o_orderpriority = '2-HIGH'
                        then 1
                else 0
        end) as high_line_count,
        sum(case
                when o_orderpriority <> '1-URGENT'
                        and o_orderpriority <> '2-HIGH'
                        then 1
                else 0
        end) as low_line_count
from
        orders,
        lineitem,
        customer,
        nation,
        region
where
        o_orderkey = l_orderkey
        and l_receiptdate >= date '1995-01-01'
        and l_receiptdate < date '1995-01-01' + interval '1' year
        and o_custkey = c_custkey
        and c_custkey = n_nationkey
        and n_nationkey = r_regionkey
group by
        l_shipmode, n_nationkey, r_regionkey
order by
        l_shipmode
LIMIT 3;

select
        region, nation, count(*)
from
        orders,
        lineitem,
        customer,
        nation,
        region
where
        o_orderkey = l_orderkey
        and o_custkey = c_custkey
        and c_custkey = n_nationkey
        and n_nationkey = r_regionkey
group by
        l_shipmode, n_nationkey, r_regionkey
order by
        l_shipmode
LIMIT 3;

select
        l_shipmode,
        sum(case
                when o_orderpriority = '1-URGENT'
                        or o_orderpriority = '2-HIGH'
                        then 1
                else 0
        end) as high_line_count,
        sum(case
                when o_orderpriority <> '1-URGENT'
                        and o_orderpriority <> '2-HIGH'
                        then 1
                else 0
        end) as low_line_count
from
        orders,
        lineitem
where
        o_orderkey = l_orderkey
        and l_shipmode in ('AIR', 'REG AIR')
        and l_commitdate < l_receiptdate
        and l_shipdate < l_commitdate
        and l_receiptdate >= date '1995-01-01'
        and l_receiptdate < date '1995-01-01' + interval '1' year
group by
        l_shipmode
order by
        l_shipmode
LIMIT 3;
admin_shkm_altostrat_com@instance-mumbai:~/alloydb/demo$




