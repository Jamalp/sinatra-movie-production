require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'pry' if development?
require 'sinatra/activerecord'

set :database, {
    adapter: 'postgresql',
    database: 'movie_production',
    host: 'localhost'
}

class Person < ActiveRecord::Base
  has_many :movies
  has_many :tasks
end

class Movie < ActiveRecord::Base
  belongs_to :person
  has_many :tasks
end

class Task < ActiveRecord::Base
  belongs_to :person
  belongs_to :movie
end

get '/' do
  @people = Person.all
  @tasks = Task.all
  @movies = Movie.all
erb :index
end

#### TASKS #####
get '/tasks' do
  @tasks = Task.all
  erb :tasks
end

post '/tasks/new' do
  Task.create(params)
  redirect to ('/tasks')
end

get '/tasks/new' do
  @movies = Movie.all
  @people = Person.all
  erb :new_task
end


get '/tasks/:id' do
  Task.find(params[:id])
  # @person = task.person
  # @movie = movie.person
  erb :task
end
post 'tasks/:id' do
  task = Task.find(params[:id])
  task.description = params[:description]
  task.complete = params[:complete]
  task.person_id = params[:person_id]
  task.movie_id = params[:movie_id]
  redirect to('/tasks')
end

get '/tasks/:id/edit' do
  task = Task.find(params[:id])
  task.description = params[:description]
  task.complete = params[:complete]
  redirect to('/tasks')
end

get 'tasks/delete' do

end



###### MOVIES ########


get '/movies' do
  @movies = Movie.all
  erb :movies
end

post '/movies/new' do
  Movie.create(params)
  redirect to('/movies')
end

get '/movies/new' do
  @movies = Movie.all
  erb :new_movie
end

get '/movies/:id' do
  Movie.find(params[:id])
  redirect to('/movies')
end

post '/movies/:id' do
  movie = Movie.find(params[:id])
  movie.description = params[:description]
  movie.person_id = params[:person_id]
  redirect to('/movies')
end

# get '/movie/:id' do
#   id = params[:id]

#   erb :movie

# end

# get '/movies/new' do
#   erb :new_movie
# end

# post '/movies/new' do

#   redirect to '/movies'
#   erb :new_movie
# end




# get '/people/new' do
#   @movies = Movie.all
#   erb :new_person
# end

# post '/people' do
#   Person.create(params)
#   redirect to '/people'

# end

get '/people' do
  @people = Person.all
  erb :people
end

# get '/people/:id' do

#   erb :person
# end


