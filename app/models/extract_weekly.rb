class ExtractWeekly < ActiveRecord::Base
  
  belongs_to :user
  attr_accessible :code_beneficiary, :commission_percentage, :commission_value, :name, :number_quota, :period_final, :period_initial, :plan, :proposal, :registration, :series, :value_contribution
  
  # validate    :validate_period_importation
  # 
  # def validate_period_importation
  #   return false if period_initial.nil? || period_final.nil?
  # 
  #   start_date_importation = DateTime.civil(bourne.project.start_date.year, bourne.project.start_date.month, 1)
  #   end_date_importation = DateTime.civil(bourne.project.end_date.year, bourne.project.end_date.month, 1)
  #   date_importation = DateTime.civil(year_bourne_realized, month_bourne_realized, 1)
  # 
  #   unless date_importation .between?(start_date_importation, end_date_importation)
  #     errors.add(I18n.t('bourne_realized.message.valid_date_month_year'), I18n.t('bourne_realized.message.valid_date_description'))
  #   end
  # end
  
  
end
