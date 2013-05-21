class ExtractMonthliesController < ApplicationController    
  
  require "rubygems"
  require "nokogiri"
  
  # GET /extract_monthlies
  # GET /extract_monthlies.json
  def index
    @users = User.where("id > #{current_user.id} OR id < #{current_user.id}").order('username').all
    
    @extract_monthlies = ExtractMonthly.select("distinct period_initial, perido_final").where("user_id = #{current_user.id}").group("id, period_initial, perido_final").order("period_initial, perido_final ASC")    
    if @extract_monthlies.count == 0
      flash[:notice] = "Nenhum arquivo importado para o Movimento Mensal!"
    end  

    @extract_weeklies = ExtractWeekly.select("distinct period_initial, period_final").where("user_id = #{current_user.id}").group("id, period_initial, period_final").order("period_initial, period_final ASC")    
    if @extract_weeklies.count == 0
      flash[:notice] = "Nenhum arquivo importado para o Movimento Mensal!"
    end 
    
    respond_to do |format|
      format.html # index.html.erb
      # format.json { render json: @extract_monthlies }
    end
  end

  # GET /extract_monthlies/1
  # GET /extract_monthlies/1.json
  def show
    @extract_monthly = ExtractMonthly.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @extract_monthly }
    end
  end

  # GET /extract_monthlies/new
  # GET /extract_monthlies/new.json
  def new
    @extract_monthly = ExtractMonthly.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @extract_monthly }
    end
  end

  # GET /extract_monthlies/1/edit
  def edit
    @extract_monthly = ExtractMonthly.find(params[:id])
  end

  # POST /extract_monthlies
  # POST /extract_monthlies.json
  def create
    @extract_monthly = ExtractMonthly.new(params[:extract_monthly])

    respond_to do |format|
      if @extract_monthly.save
        format.html { redirect_to @extract_monthly, notice: 'Extract monthly was successfully created.' }
        format.json { render json: @extract_monthly, status: :created, location: @extract_monthly }
      else
        format.html { render action: "new" }
        format.json { render json: @extract_monthly.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /extract_monthlies/1
  # PUT /extract_monthlies/1.json
  def update
    @extract_monthly = ExtractMonthly.find(params[:id])

    respond_to do |format|
      if @extract_monthly.update_attributes(params[:extract_monthly])
        format.html { redirect_to @extract_monthly, notice: 'Extract monthly was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @extract_monthly.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /extract_monthlies/1
  # DELETE /extract_monthlies/1.json
  def destroy
    @extract_monthly = ExtractMonthly.find(params[:id])
    @extract_monthly.destroy

    respond_to do |format|
      format.html { redirect_to extract_monthlies_url }
      format.json { head :no_content }
    end
  end    
  
  def import_extract_monthlies   
    
    if params[:file_import].blank?
      redirect_to extract_monthlies_path, :notice => "Selecione um arquivo para ser importado."
    else
      file_name = params[:file_import].to_s
      doc = Nokogiri::HTML(File.open(Rails.public_path + "/files_import/#{file_name}"))

      # get date initial and date final of extract
      date_extract_payment_monthly = doc.search("//b[@class = 'f-18']").first   
      date_extract_payment = date_extract_payment_monthly.to_s   

      rows    = doc.xpath('//table[4]/tr/td//text()')
      string  = rows
      total = []
      rows.each do |line|
        tmp = []
        line.text.each_char do |item|
          if item.match(/[\w\,\.]/)
            tmp << item
          else
            tmp << '|'
          end
        end
        total << tmp.join
      end  
      total.each do |item|  
        if item.match(/(\d+)\|+(\d+)\|+(\d+)\|+(\w+)\|+(\d+)\|+(\d+)\|+([\d\,\.]+)\|+([\d\,\.]+)\|+([\d\,\.]+)/)
          @extract_payment_monthly = ExtractMonthly.new(params[:extract_payment])
          @extract_payment_monthly[:user_id] = current_user.administrator? == true ? params[:user].to_i : current_user.id
          @extract_payment_monthly[:name] = params[:name]
          @extract_payment_monthly[:registration] = "#{$1}"
          @extract_payment_monthly[:series] = "#{$2}"
          @extract_payment_monthly[:proposal] = "#{$3}"
          @extract_payment_monthly[:code_beneficiary] = "#{$4}"
          @extract_payment_monthly[:plan] = "#{$5}"
          @extract_payment_monthly[:number_quota] = "#{$6}"
          @extract_payment_monthly[:value_contribution] = "#{$7}".tr(",",".")
          @extract_payment_monthly[:commission_percentage] = "#{$8}".tr(",",".")
          @extract_payment_monthly[:commission_value] = "#{$9}".tr(",",".")
          @extract_payment_monthly[:period_initial] = date_extract_payment[40,10].to_datetime
          @extract_payment_monthly[:perido_final] = date_extract_payment[55,10].to_datetime
          # @extract_payment_monthly.save!
          # puts "#{$1} - #{$2} #{$3} - #{$4} - #{$5} - #{$6} - #{$7} - #{$8} - #{$9}"
        end
      end
      respond_to do |format|
        # if @extract_payment.save
          format.html { redirect_to extract_monthlies_path, :notice => 'Extract payment was successfully created.' }
        # end
      end
      
    end 
                                                                 
  end 
  
  def validate_importation?
    
  end 
  
  # def list_full_customers
  #   @search = Customer.search(params[:search])
  #   @customers = @search.where(:name_file => "#{params[:name_file]}").page(params[:page]).order("name_customer")
  #   session[:name_file] = @customers[0].name_file
  #   session[:month_reference] = @customers[0].month_reference
  #   session[:year_reference] = @customers[0].year_reference   
  #   # authorize! :list_full_customers, Customer   
  # end

  def search_per_parameter
    @extract_monthlies = ExtractMonthly.all
    # @extract_monthlies = @search.where(:name_file => "#{params[:name_file]}").page(params[:page]).order("name_customer")
      
  end
  
  
  def list_extract_monthly  
    @per_ini = params[:period_initial].to_datetime
    @per_fim = params[:perido_final].to_datetime      
    
    @search = ExtractMonthly.search(params[:search])
    @customers = @search.where(:registration => "#{params[:registration]}").page(params[:page]).order("registration")
    
    # sql = "select id, user_id, name, registration, series, proposal, code_beneficiary, plan, number_quota, value_contribution, commission_percentage, commission_value, period_initial, perido_final from extract_monthlies where period_initial = " + '"#{per_ini}"' + " and perido_final = '2012/03/08' group by id, user_id, name, registration, series, proposal, code_beneficiary, plan, number_quota, value_contribution, commission_percentage, commission_value, period_initial, perido_final ORDER BY id"
    # @extract_monthlies = ExtractMonthly.find_by_sql(sql)
    @extract_monthlies = ExtractMonthly.select("id, user_id, name, registration, series, proposal, code_beneficiary, plan, number_quota, value_contribution, commission_percentage, commission_value, period_initial, perido_final").where("period_initial = '#{@per_ini}' and perido_final = '#{@per_fim}'").group("id, user_id, name, registration, series, proposal, code_beneficiary, plan, number_quota, value_contribution, commission_percentage, commission_value, period_initial, perido_final").order("id").all
    if @extract_monthlies.count == 0
      flash[:notice] = "Nenhum arquivo importado para o Movimento Mensal!"
    end
    respond_to do |format|
      format.html # index.html.erb
      # format.json { render json: @extract_monthlies }
    end
  end
end
