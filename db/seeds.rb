# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
puts 'EMPTY THE MONGODB DATABASE'
Mongoid.master.collections.reject { |c| c.name =~ /^system./}.each(&:drop)
#puts 'SETTING UP DEFAULT USER LOGIN'
#user = User.create! :name => 'First User', :email => 'user@test.com', :password => 'please', :password_confirmation => 'please'
#puts 'New user created: ' << user.name

puts 'Opening the file'
file = File.new("all_Ohio/dc_acs_2009_5yr_g00__data1.txt", "r")
#First line is trash internal column names used by the source database,we done't need them'
file.gets
#Second line is human readable column name
line = file.gets
titleArray = line.to_s.split('|')

#puts titleArray[6]
#while(line = file.gets)
#  splitLine = line.to_s.split("|")
#  puts splitLine[6]
#  #now loop through each line, build an object (probably a hash) and save it to mongo, once we have a unique key to index with
#end
line = file.gets
#splitLine = line.to_s.split("|")
#titleArray.count.times {|i|puts titleArray[i] + ':' + splitLine[i] }
##titleArray.each {|title| puts title + ':' + }
#puts line