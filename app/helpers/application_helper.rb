module ApplicationHelper  
  
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end   
  
  def type_plan_selected(code)   
    params[:type_plan].to_i == code.to_i ? true : false
  end 
  
  def show_footer(controller, action)  
    type_footer = 0
    if current_user.blank?
      if controller == 'registrations' && action == 'new' || controller == 'sessions' && action == 'new'
        type_footer = 1
      end
    else
      type_footer = 1     
    end
    
    if type_footer == 0
      render 'shared/footer_full' 
    else
      render 'shared/footer' 
    end  
  end
end
