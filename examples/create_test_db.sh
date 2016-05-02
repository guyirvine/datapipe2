dropdb datapipe2
createdb datapipe2

cat << EOF | psql datapipe2
BEGIN;

CREATE TABLE test_tbl( id BIGINT, name VARCHAR );
INSERT INTO test_tbl( id, name ) VALUES ( 1, 'One' );
INSERT INTO test_tbl( id, name ) VALUES ( 2, 'Two' );

END;
EOF
