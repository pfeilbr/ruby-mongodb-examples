require 'rubygems'
require 'bundler/setup'
require 'mongo'
require 'databasedotcom'
require 'databasedotcom_additions'
require 'pp'

include Mongo

puts %{connect}
c = MongoClient.new("localhost", 27017)

puts %{list databases}
pp c.database_names

puts %{get mydb}
db = c.db('mydb')

puts %{list collections in mydb}
pp db.collection_names

puts %{create users collection}
users = db['users']

puts %{delete all users if any exists}
users.remove()

puts %{create some users with a random age}
1000.times {|i| users.save({name: %{user#{i}}, age: (1..70).to_a.sample}) }

puts %{display all users}
pp users.find.map {|u| u['name']}.join(',')

puts %{find 'user3' and display}
pp users.find({name: 'user3'}).to_a

puts %{display age of 'user5'}
pp users.find({name: 'user5'}, fields: ['age']).to_a

puts %{count of users that have an age of 10}
pp users.find({age: 10}).count