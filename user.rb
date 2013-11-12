require 'dm-core'
require 'dm-migrations'

class User
  include DataMapper::Resource
  property :id, Serial
  property :username, String
  property :password, String
  property :released_on, DateTime
end

DataMapper.finalize

DataMapper.setup(:default,'sqlite:development.db')

DataMapper.auto_migrate!


get '/users' do
  @users = User.all
  slim :users
end

get '/user/new' do
  @user = User.new
  slim :new_user
end

get '/user/:id' do |id|
  @song = Song.get(id)
  slim :show_user
end

get '/user/:id/edit' do
  @user = User.get(params[:id])
  slim :edit_user
end

post '/users' do
  user = User.create(params[:user])
  redirect to("/users/#{user.id}")
end

put 'users/:id' do
  user = User.get(params[:id])
  user.update(params[:user])
  redirect to("/users/#{user.id}")
end

delete '/users/:id' do
   User.get(params[:id]).destroy
   redirect to('/users')
end
