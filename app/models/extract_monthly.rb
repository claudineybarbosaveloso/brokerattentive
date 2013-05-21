class ExtractMonthly < ActiveRecord::Base
  belongs_to :user
  attr_accessible :code_beneficiary, :commission_percentage, :commission_value, :name, :number_quota, :perido_final, :period_initial, :plan, :proposal, :registration, :series, :value_contribution
end
      