+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/PostgreSQL"
date = "2008-11-09T14:18:01Z"
+++

# PostgreSQL で RDBMS サーバの構築  {#y1e0d6dd}

# インストール  {#q6011042}


```
# cd /usr/ports/databases/postgresql83-server
# make install clean
======================================================================
For procedural languages and postgresql functions, please note that
you might have to update them when updating the server.

If you have many tables and many clients running, consider raising
kern.maxfiles using sysctl(8), or reconfigure your kernel
appropriately.

The port is set up to use autovacuum for new databases, but you might
also want to vacuum and perhaps backup your database regularly. There
is a periodic script, /usr/local/etc/periodic/daily/502.pgsql, that
you may find useful. You can use it to backup and perfom vacuum on all
databases nightly. Per default, it perfoms `vacuum analyze'. See the
script for instructions. For autovacuum settings, please review
~pgsql/data/postgresql.conf.

To allow many simultaneous connections to your PostgreSQL server, you
should raise the SystemV shared memory limits in your kernel. Here are
example values for allowing up to 180 clients (configurations in
postgresql.conf also needed, of course):
  options         SYSVSHM
  options         SYSVSEM
  options         SYSVMSG
  options         SHMMAXPGS=65536
  options         SEMMNI=40
  options         SEMMNS=240
  options         SEMUME=40
  options         SEMMNU=120

If you plan to access your PostgreSQL server using ODBC, please
consider running the SQL script /usr/local/share/postgresql/odbc.sql
to get the functions required for ODBC compliance.

Please note that if you use the rc script,
/usr/local/etc/rc.d/postgresql, to initialize the database, unicode
(UTF-8) will be used to store character data by default.  Set
postgresql_initdb_flags or use login.conf settings described below to
alter this behaviour. See the start rc script for more info.

To set limits, environment stuff like locale and collation and other
things, you can set up a class in /etc/login.conf before initializing
the database. Add something similar to this to /etc/login.conf:
---
postgres:\
        :lang=en_US.UTF-8:\
        :setenv=LC_COLLATE=C:\
        :tc=default:
---
and run `cap_mkdb /etc/login.conf'.
Then add 'postgresql_class="postgres"' to /etc/rc.conf.

======================================================================

To initialize the database, run

  /usr/local/etc/rc.d/postgresql initdb

You can then start PostgreSQL by running:

  /usr/local/etc/rc.d/postgresql start

For postmaster settings, see ~pgsql/data/postgresql.conf

NB. FreeBSD's PostgreSQL port logs to syslog by default
    See ~pgsql/data/postgresql.conf for more info

======================================================================

To run PostgreSQL at startup, add
'postgresql_enable="YES"' to /etc/rc.conf

======================================================================
```


```
# sudoedit /etc/login.conf
postgres:\
	:lang=en_US.UTF-8:\
	:setenv=LC_COLLATE=C:\
	:tc=default:

# sudo cap_mkdb /etc/login.conf
```


```
# sudoedit /etc/rc.conf
postgresql_enable="YES"
postgresql_class="postgres"
```


```
# sudo /usr/local/etc/rc.d/postgresql initdb
The files belonging to this database system will be owned by user "pgsql".
This user must also own the server process.

The database cluster will be initialized with locales
  COLLATE:  C
  CTYPE:    en_US.UTF-8
  MESSAGES: en_US.UTF-8
  MONETARY: en_US.UTF-8
  NUMERIC:  en_US.UTF-8
  TIME:     en_US.UTF-8
The default text search configuration will be set to "english".

creating directory /usr/local/pgsql/data ... ok
creating subdirectories ... ok
selecting default max_connections ... 40
selecting default shared_buffers/max_fsm_pages ... 28MB/179200
creating configuration files ... ok
creating template1 database in /usr/local/pgsql/data/base/1 ... ok
initializing pg_authid ... ok
initializing dependencies ... ok
creating system views ... ok
loading system objects' descriptions ... ok
creating conversions ... ok
creating dictionaries ... ok
setting privileges on built-in objects ... ok
creating information schema ... ok
vacuuming database template1 ... ok
copying template1 to template0 ... ok
copying template1 to postgres ... ok

WARNING: enabling "trust" authentication for local connections
You can change this by editing pg_hba.conf or using the -A option the
next time you run initdb.

Success. You can now start the database server using:

    /usr/local/bin/postgres -D /usr/local/pgsql/data
or
    /usr/local/bin/pg_ctl -D /usr/local/pgsql/data -l logfile start

```


```
# sudo /usr/local/etc/rc.d/postgresql start
```


```
# sudo passwd pgsql
New Password:
Retype New Password:

# su pgsql
# cd ~
# touch .pgpass
# chmod 600 .pgpass
# vi .pgpass
localhost:5432:template1:pgsql:パスワード

# exit

# psql -U pgsql template1

Welcome to psql 8.3.5, the PostgreSQL interactive terminal.

Type:  \copyright for distribution terms
       \h for help with SQL commands
       \? for help with psql commands
       \g or terminate with semicolon to execute query
       \q to quit

template1=# ALTER USER pgsql ENCRYPTED PASSWORD 'パスワード';
```
