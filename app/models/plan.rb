class Plan < ActiveRecord::Base   
  has_many :users
  attr_accessible :maximum_customers, :name, :price
  
end