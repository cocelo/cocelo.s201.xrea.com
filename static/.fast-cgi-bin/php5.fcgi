#!/bin/bash
PHPRC="php5.ini"
PHP_FCGI_CHILDREN=1
PHP_FCGI_MAX_REQUESTS=10000
export PHPRC
export PHP_FCGI_CHILDREN
export PHP_FCGI_MAX_REQUESTS
exec /usr/local/bin/php5
