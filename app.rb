#!/usr/bin/ruby
require 'pg'
require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/train')
require('./lib/city')
require 'pg'

DB = PG.connect({:dbname => 'train_system'})

get('/') do
  erb(:index)
end

get('/operator') do
  erb(:system_operator)
end

get('/operator/city/list') do
  @cities = City.all
  erb(:cities)
end

get('/operator/trains') do
  @trains = Train.all
  erb(:trains)
end

get('/operator/city/new') do
  @cities = City.all
  erb(:city/new)
end
