class ListPlansController < ApplicationController

  skip_before_filter :authenticate_user!, :only => [:index]

  def index
    @plans = Plan.order('id').all
    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
