admin_shkm_altostrat_com@instance-mumbai:~/alloydb/demo$ pgbench --host=10.45.193.230 --username=postgres -n -c 5 -j 5 -S -T 9000 -f pgbench.sql  testdb


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




