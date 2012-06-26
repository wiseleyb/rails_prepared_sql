# Prepared SQL

## Background

One project I've been working on has a bunch of remote databases that we need to attach to (but don't control).  The user specifies columns and we run jobs that insert data into these remote tables.  This, of course, generates some really ugly sql, especially when the data you're inserting contains scraped websites.  

## One Solution
Most DB drivers have something along the lines of **prepare**. Of course, it's different for each driver.  This is a "just as much as I needed" class that handles inserts for MySQL and PostgreSQL.

    ps = PreparedSql.new(ActiveRecord::Base.connection)
    ps.execute_prepared_sql('scrape_results', 
          ['id', 'url', 'data'], 
          [1, 'http://site.com', '<h1>Site.com</h1>'])

## Adding to your Rails project:

    git clone git@github.com:wiseleyb/rails_preprared_sql.git 
    cp rails_prepared_sql/prepared_sql.rb [yourproject]/lib/
    
## More info
* [Discussion for PostgreSQL on StackOverflow](http://stackoverflow.com/questions/10841390/example-of-a-prepared-insert-statement-using-ruby-pg-gem)
* [Doc for PostgreSQL connection](http://rubydoc.info/gems/pg/PG/Connection)
* [Blog post for MySQL](http://blog.aizatto.com/2007/05/19/connecting-to-mysql-using-ruby/)
* [Doc for MySQL connection](http://www.tmtm.org/en/mysql/ruby/)
* [Discussion for SQLite3 on StackOverflow](http://stackoverflow.com/questions/9614236/escaping-strings-for-ruby-sqlite-insert) * note - I didn't implement this in this project
* [Doc for SQLite3](http://rubydoc.info/github/luislavena/sqlite3-ruby/master/SQLite3/Database)





