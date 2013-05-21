class Consolidate < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :code_beneficiary, :commission_percentage, :commission_value, :name, :number_quota, :period_final, :period_initial, :plan, :proposal, :registration, :series, :value_contribution
end
