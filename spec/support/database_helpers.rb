class DatabaseHelpers
  def self.insert_test_run
    DatabaseConnection.instance.connection.query('delete from test_runs where id = $1::int', [1])
    query = <<-SQL
        insert into test_runs(id, test_id, location, created_at, updated_at)
        values($1::int, $2::int, $3::varchar, now(), now())
    SQL

    DatabaseConnection.instance.connection.query(query, [1, 1, 'warsaw'])
  end

  def self.select_test_run(id)
    query = <<-SQL
        select * from test_runs where id = $1::int
    SQL

    DatabaseConnection.instance.connection.query(query, [id]).first
  end

  def self.create_structure
    query = <<-SQL
      CREATE TABLE IF NOT EXISTS test_runs
      (
        id serial NOT NULL,
        test_id integer NOT NULL,
        location character varying NOT NULL,
        result boolean DEFAULT true,
        created_at timestamp without time zone NOT NULL,
        updated_at timestamp without time zone NOT NULL,
        failed_assertions json,
        response_body_file_path character varying,
        executed_at timestamp without time zone,
        CONSTRAINT test_runs_pkey PRIMARY KEY (id)
      )
    SQL

    DatabaseConnection.instance.connection.query(query)
  end
end