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

get('/operator/trains/list') do
  @trains = Train.all
  erb(:trains)
end

get('/operator/city/new') do
  @cities = City.all
  erb(:city_new)
end

get('/operator/train/new') do
  @trains = Train.all
  erb(:train_new)
end

post('/operator/city/list') do
  city_name = params.fetch(:city_name)
  City.new(id: nil, name: city_name).save
  @cities = City.all
  erb(:cities)
end

post('/operator/train/list') do
  train_number = params.fetch(:train_number)
  nickname = params.fetch(:nickname)
  Train.new(train_number: train_number, nickname: nickname, id: nil).save
  @trains = Train.all
  erb(:trains)
end

delete("/operator/city/list/:id") do
  @city = City.find(params.fetch("id").to_i())
  @city.delete()
  @cities = City.all()
  erb(:cities)
end

delete("/operator/train/list/:id") do
  @train = Train.find(params.fetch("id").to_i())
  @train.delete()
  @trains = Train.all()
  erb(:trains)
end

patch("/operator/city/list/:id") do
  name = params.fetch("name")
  @city = City.find(params.fetch("id").to_i())
  @city.update({:name => name})
  @cities = City.all
  erb(:cities)
end

patch("/operator/train/list/:id") do
  train_number = params.fetch("train_number")
  nickname = params.fetch("nickname")
  @train = Train.find(params.fetch("id").to_i())
  @train.update({:train_number => train_number, :nickname => nickname})
  @trains = Train.all
  erb(:trains)
end

get('/operator/city/city_edit/:id') do
  @city = City.find(params.fetch("id").to_i())
  erb(:city_edit)
end

get('/operator/train/train_edit/:id') do
  @train = Train.find(params.fetch("id").to_i())
  erb(:train_edit)
end
