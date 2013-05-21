require 'test_helper'

class ExtractWeekliesControllerTest < ActionController::TestCase
  setup do
    @extract_weekly = extract_weeklies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:extract_weeklies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create extract_weekly" do
    assert_difference('ExtractWeekly.count') do
      post :create, extract_weekly: { code_beneficiary: @extract_weekly.code_beneficiary, commission_percentage: @extract_weekly.commission_percentage, commission_value: @extract_weekly.commission_value, name: @extract_weekly.name, number_quota: @extract_weekly.number_quota, period_final: @extract_weekly.period_final, period_initial: @extract_weekly.period_initial, plan: @extract_weekly.plan, proposal: @extract_weekly.proposal, registration: @extract_weekly.registration, series: @extract_weekly.series, value_contribution: @extract_weekly.value_contribution }
    end

    assert_redirected_to extract_weekly_path(assigns(:extract_weekly))
  end

  test "should show extract_weekly" do
    get :show, id: @extract_weekly
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @extract_weekly
    assert_response :success
  end

  test "should update extract_weekly" do
    put :update, id: @extract_weekly, extract_weekly: { code_beneficiary: @extract_weekly.code_beneficiary, commission_percentage: @extract_weekly.commission_percentage, commission_value: @extract_weekly.commission_value, name: @extract_weekly.name, number_quota: @extract_weekly.number_quota, period_final: @extract_weekly.period_final, period_initial: @extract_weekly.period_initial, plan: @extract_weekly.plan, proposal: @extract_weekly.proposal, registration: @extract_weekly.registration, series: @extract_weekly.series, value_contribution: @extract_weekly.value_contribution }
    assert_redirected_to extract_weekly_path(assigns(:extract_weekly))
  end

  test "should destroy extract_weekly" do
    assert_difference('ExtractWeekly.count', -1) do
      delete :destroy, id: @extract_weekly
    end

    assert_redirected_to extract_weeklies_path
  end
end
