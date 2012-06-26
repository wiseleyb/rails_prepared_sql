class PreparedSql
  
  SUPPORTED_DBS = %w(PostgreSQL MySQL)

  mattr_accessor :db_connection, :raw_connection
  
  def initialize(connection)
    @db_connection = connection
    @raw_connection = connection.raw_connection
    unless SUPPORTED_DBS.include?(@db_connection.adapter_name)
      raise "Unsupported db '#{@db_connection.adapter_name}' - this only supports #{SUPPORTED_DBS.join(",")}" 
    end
  end
  
  
  def prepare_sql_values(num)
    case @db_connection.adapter_name
      when 'PostgreSQL'
        num.times.collect {|i| "$#{i+1}"}.join(",")
      when 'MySQL'
        (['?'] * num).join(",")
      else
        raise "Unsupported db '#{@db_connection.adapter_name}' - this only supports #{SUPPORTED_DBS.join(",")}" 
    end
  end
  
  def execute_prepared_sql(table_name, columns, values)
    sql = "INSERT INTO #{table_name} (#{columns.flatten.join(",")}) VALUES (#{prepare_sql_values(columns.size)})"
    case @db_connection.adapter_name
      when 'PostgreSQL'
        statement = "statement#{Time.now.to_f}"
        @raw_connection.prepare(statement, sql)
        @raw_connection.exec_prepared(statement, values.flatten)
      when 'MySQL'
        insert_sql = @raw_connection.prepare sql
        insert_sql.execute *values.flatten 
        insert_sql.close
      else
        raise "Unsupported db '#{@db_connection.adapter_name}' - this only supports #{SUPPORTED_DBS.join(",")}" 
    end
  end
  
end