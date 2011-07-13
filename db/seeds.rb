# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


# Countries
puts "Populating Countries..."
Country.delete_all
open("db/seed-data/countries.txt") do |countries|
    countries.read.each_line do |country|
        code, name = country.chomp.split("|")
        Country.create!(:name => name, :code => code)
    end
end

# Populate Mexico States
puts "Populating States..."
State.delete_all
open("db/seed-data/states.txt") do |states|
    states.read.each_line do |state|
        code, name = state.chomp.split("|")
        State.create!(:name => name, :code => code)
    end
end

