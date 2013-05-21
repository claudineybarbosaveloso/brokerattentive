class WithoutPermissionController < ApplicationController  
  
  def index
    redirect_to signout_path
  end
end
