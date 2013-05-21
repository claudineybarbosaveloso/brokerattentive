class DashboardController < ApplicationController
  def index   
    @users = User.where("id > #{current_user.id} OR id < #{current_user.id}").order('username').all
    @extract_monthlies = ExtractMonthly.select("to_char(period_initial, 'month')").where("user_id = #{current_user.id}").group("to_char(period_initial, 'month')")    
    @extract_weeklies = ExtractWeekly.select("to_char(period_initial, 'month')").where("user_id = #{current_user.id}").group("to_char(period_initial, 'month')")    
    @consolidates = Consolidate.select("to_char(period_initial, 'month')").where("user_id = #{current_user.id}").group("to_char(period_initial, 'month')")    
    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
