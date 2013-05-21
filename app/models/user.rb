class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable   
               
  belongs_to :plan
  
  has_many :extract_monthlies
  has_many :extract_weeklies
  
  STATUS = %w(Ativo Inativo)
  
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable

  # devise :database_authenticatable, :recoverable, :rememberable, :registerable,  
  #        :trackable, :validatable


   devise :database_authenticatable,
          :recoverable, :rememberable, :registerable, :trackable, :validatable
         

  # Setup accessible (or protected) attributes for your model
  attr_accessible :cpf_cnpj, 
                  :username, 
                  :email, 
                  :password, 
                  :password_confirmation, 
                  :remember_me,   
                  :status,
                  :plan_id,
                  :administrator,
                  :terms_of_service  
  
  # attr_accessible :title, :body
  
  validates_acceptance_of :terms_of_service, :on => :create, :accept => true, :allow_nil => false  
end
