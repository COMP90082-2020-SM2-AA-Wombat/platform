-- db name
use AA_AUDIT;

CREATE TABLE input_table (
  name VARCHAR(20),
  color VARCHAR(10)
);

INSERT INTO input_table
  (name, color)
VALUES
  ('Lancelot', 'blue'),
  ('Galahad', 'yellow');