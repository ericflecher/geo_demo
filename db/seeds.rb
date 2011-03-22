# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

require 'deomographic_importer'

include DeomographicImporter

puts 'Emptying the database'
Mongoid.master.collections.reject { |c| c.name =~ /^system./}.each(&:drop)
importDemographicFile("all_Ohio/dc_acs_2009_5yr_g00__data1.txt")