# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)    


#create default plans
Plan.create(:name => 'Degustacao', :maximum_customers => 0, :price => 0.00)
Plan.create(:name => 'Bronze', :maximum_customers => 100, :price => 100.00)
Plan.create(:name => 'Prata', :maximum_customers => 300, :price => 200.00)
Plan.create(:name => 'Ouro', :maximum_customers => 999999, :price => 300.00)

