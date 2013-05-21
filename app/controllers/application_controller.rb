class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  protect_from_forgery  
  
  def after_sign_in_path_for(resource)
    if resource.is_a?(User)   
      if !current_user.administrator == true  
        if current_user.status == "Ativo" 
          "/dashboard"
        else    
          session[:without_permission] = true
          "/without_permission"
        end  
      else 
        super       
        "/dashboard" 
      end
    end
  end   
  
  def after_sign_out_path_for(resource)  
    if session[:without_permission]
      welcome_path
    else
      root_path
    end
  end
  
  def become   
    # unless current_user.status == "Inativo"
    #   redirect_to root_path
    # end    
    if !current_user.blank?
      if current_user.status == "Inativo"
        redirect_to signout_path
      end
    end                
  end
end
