require 'test_helper'

class ExtractMonthliesControllerTest < ActionController::TestCase
  setup do
    @extract_monthly = extract_monthlies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:extract_monthlies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create extract_monthly" do
    assert_difference('ExtractMonthly.count') do
      post :create, extract_monthly: { code_beneficiary: @extract_monthly.code_beneficiary, commission_percentage: @extract_monthly.commission_percentage, commission_value: @extract_monthly.commission_value, name: @extract_monthly.name, number_quota: @extract_monthly.number_quota, perido_final: @extract_monthly.perido_final, period_initial: @extract_monthly.period_initial, plan: @extract_monthly.plan, proposal: @extract_monthly.proposal, registration: @extract_monthly.registration, series: @extract_monthly.series, value_contribution: @extract_monthly.value_contribution }
    end

    assert_redirected_to extract_monthly_path(assigns(:extract_monthly))
  end

  test "should show extract_monthly" do
    get :show, id: @extract_monthly
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @extract_monthly
    assert_response :success
  end

  test "should update extract_monthly" do
    put :update, id: @extract_monthly, extract_monthly: { code_beneficiary: @extract_monthly.code_beneficiary, commission_percentage: @extract_monthly.commission_percentage, commission_value: @extract_monthly.commission_value, name: @extract_monthly.name, number_quota: @extract_monthly.number_quota, perido_final: @extract_monthly.perido_final, period_initial: @extract_monthly.period_initial, plan: @extract_monthly.plan, proposal: @extract_monthly.proposal, registration: @extract_monthly.registration, series: @extract_monthly.series, value_contribution: @extract_monthly.value_contribution }
    assert_redirected_to extract_monthly_path(assigns(:extract_monthly))
  end

  test "should destroy extract_monthly" do
    assert_difference('ExtractMonthly.count', -1) do
      delete :destroy, id: @extract_monthly
    end

    assert_redirected_to extract_monthlies_path
  end
end
