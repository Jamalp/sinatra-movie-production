require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'pry' if development?

helpers do
  # This helps us run SQL commands
  def run_sql(sql)
    db = PG.connect(dbname: 'movie_production', host: 'localhost')
    result = db.exec(sql)
    db.close
    result
  end
end

get '/' do
   sql = "select * from tasks"
  @tasks = run_sql(sql)

  sql = "select * from movies"
  @movies = run_sql(sql)

  sql = "select * from people"
  @people = run_sql(sql)

erb :index
end

get '/movies' do
  sql = "SELECT * FROM movies"
  @movies = run_sql(sql).first
  erb :movies
end

get '/movie/:id' do
  id = params[:id]
  sql = "SELECT * FROM movies WHERE id = #{id}"
  @movie = run_sql(sql).first
  erb :movie

end

get '/movies/new' do
  erb :new_movie
end

post '/movies/new' do
  name = params[:name]
  description = params[:description]
  people_id = params[:people_id]
  sql = "INSERT INTO movies (name, description, people_id) VALUES ('#{name}','#{description}',#{people_id});"
  run_sql(sql)
  redirect to '/movies'
  erb :new_movie
end

get '/tasks' do
  sql = "SELECT * FROM tasks"
  @tasks = run_sql(sql).first
  erb :tasks
end

get '/tasks/:id' do
  id = params[:id]
  sql = "SELECT * FROM tasks WHERE id = #{'id'}"
  @tasks = run_sql(sql).first
  erb :task
end

get '/tasks/new' do
  erb :new_task
end

post '/tasks/new' do
  name = params[:name]
  description = params[:description]
  complete = params[:complete]
  movie_id = params[:movie_id]
  people_id = params[:people_id]
  sql = "INSERT INTO movies (name, description, complete, movie_id, people_id) VALUES ('#{name}','#{description}',#{complete},#{movie_id},#{people_id});"
  run_sql(sql)
  redirect to '/tasks'

  erb :new_task
end

get '/people/new' do
  erb :new_person
end

post '/people/new' do
  name = params[:name]
  title = params[:title]
  sql = "INSERT INTO people (name, title) VALUES ('#{name}','#{title}');"
  run_sql(sql)
  redirect to '/people'
  erb :new_person
end

get '/people' do
sql = "SELECT * FROM people"
  @people = run_sql(sql) # @people is an array
  # @people = run_sql(sql).first # gives you a hash

  erb :people
end

get '/people/:id' do
  id = params[:id]
  sql = "SELECT * FROM people WHERE id = #{'id'}"
  @person = run_sql(sql).first
  erb :person
end


