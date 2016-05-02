sql = 'SELECT * FROM test_tbl'

db_to_csv sql, './data', 'test.csv'
db_to_json sql, './data', 'test.json'
