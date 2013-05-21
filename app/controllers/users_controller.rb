class UsersController < ApplicationController
  
  def index  
    # @users = User.where(:status => 'Ativo').all
    @users = User.order('username').all
    respond_to do |format|
      format.html # index.html.erb
    end
  end  
  
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
    end
    
  end
  
  def edit   
    @user = User.find(params[:id])
  end  
  
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      # format.json { render json: @user }
    end
    
  end  
  
  def create
    @user = User.new(params[:user])    
    if @user.save
      redirect_to users_path, :notice => 'Usuario criado com sucesso'
    else
      render :action => :new
    end
  end  
  
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'Usuario atualizado com sucesso.' }
      else
        render :action => :edit
      end
    end
  end 
  
  def destroy
    @user = User.find(params[:id])
    update = @user.update_attributes(
    :status => 'Inativo' )    
    if update   
      flash[:notice] = "Usuario excluido com sucesso!"
    else
      flash[:alert] = "Ocorreu um erro ao tentar excluir o usuario!"
    end
    redirect_to users_path
  end    
  
  def change_password
    @user = current_user
  end
           
  def update_status                      
    @user = User.find(params[:id])
    update = @user.update_attributes(
    :status => 'Ativo' )    
    if update   
      flash[:notice] = "Senha alterada com sucesso!"
    else
      flash[:alert] = "Ocorreu um erro ao tentar alterar a sua senha!"
    end
    redirect_to users_path
    
  end
end
