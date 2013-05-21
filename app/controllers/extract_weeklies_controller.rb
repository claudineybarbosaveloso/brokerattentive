class ExtractWeekliesController < ApplicationController
  
  # GET /extract_weeklies
  # GET /extract_weeklies.json
  def index
    @users = User.where("id > #{current_user.id} OR id < #{current_user.id}").order('username').all    
    @extract_weeklies = ExtractWeekly.select("distinct period_initial, period_final").where("user_id = #{current_user.id}").group("id, period_initial, period_final").order("period_initial, period_final ASC")    
    if @extract_weeklies.count == 0
      flash[:notice] = "Nenhum arquivo importado para o Movimento Mensal!"
    end 
    
    @extract_monthlies = ExtractMonthly.select("distinct period_initial, perido_final").where("user_id = #{current_user.id}").group("id, period_initial, perido_final").order("period_initial, perido_final ASC")    
    if @extract_monthlies.count == 0
      flash[:notice] = "Nenhum arquivo importado para o Movimento Mensal!"
    end  
    
    
    respond_to do |format|
      format.html # index.html.erb
      # format.json { render json: @extract_weeklies }
    end
  end

  # GET /extract_weeklies/1
  # GET /extract_weeklies/1.json
  def show
    @extract_weekly = ExtractWeekly.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @extract_weekly }
    end
  end

  # GET /extract_weeklies/new
  # GET /extract_weeklies/new.json
  def new
    @extract_weekly = ExtractWeekly.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @extract_weekly }
    end
  end

  # GET /extract_weeklies/1/edit
  def edit
    @extract_weekly = ExtractWeekly.find(params[:id])
  end

  # POST /extract_weeklies
  # POST /extract_weeklies.json
  def create
    @extract_weekly = ExtractWeekly.new(params[:extract_weekly])

    respond_to do |format|
      if @extract_weekly.save
        format.html { redirect_to @extract_weekly, notice: 'Extract weekly was successfully created.' }
        format.json { render json: @extract_weekly, status: :created, location: @extract_weekly }
      else
        format.html { render action: "new" }
        format.json { render json: @extract_weekly.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /extract_weeklies/1
  # PUT /extract_weeklies/1.json
  def update
    @extract_weekly = ExtractWeekly.find(params[:id])

    respond_to do |format|
      if @extract_weekly.update_attributes(params[:extract_weekly])
        format.html { redirect_to @extract_weekly, notice: 'Extract weekly was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @extract_weekly.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /extract_weeklies/1
  # DELETE /extract_weeklies/1.json
  def destroy
    @extract_weekly = ExtractWeekly.find(params[:id])
    @extract_weekly.destroy

    respond_to do |format|
      format.html { redirect_to extract_weeklies_url }
      format.json { head :no_content }
    end
  end  
  
  def import_extract_weeklies
    file_name = params[:file_import].to_s
    doc = Nokogiri::HTML(File.open(Rails.public_path + "/files_import/#{file_name}"))
    
    # get date initial and date final of extract
    date_extract_payment_weeklies = doc.search("//b[@class = 'f-18']").first   
    date_extract_payment = date_extract_payment_weeklies.to_s  
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
        @extract_payment_weekly = ExtractWeekly.new(params[:extract_payment])
        @extract_payment_weekly[:user_id] = current_user.administrator? == true ? params[:user].to_i : current_user.id
        @extract_payment_weekly[:name] = params[:name]
        @extract_payment_weekly[:registration] = "#{$1}"
        @extract_payment_weekly[:series] = "#{$2}"
        @extract_payment_weekly[:proposal] = "#{$3}"
        @extract_payment_weekly[:code_beneficiary] = "#{$4}"
        @extract_payment_weekly[:plan] = "#{$5}"
        @extract_payment_weekly[:number_quota] = "#{$6}"
        @extract_payment_weekly[:value_contribution] = "#{$7}".tr(",",".")
        @extract_payment_weekly[:commission_percentage] = "#{$8}".tr(",",".")
        @extract_payment_weekly[:commission_value] = "#{$9}".tr(",",".")
        @extract_payment_weekly[:period_initial] = date_extract_payment[40,10].to_datetime
        @extract_payment_weekly[:period_final] = date_extract_payment[55,10].to_datetime
        @extract_payment_weekly.save!
        # puts "#{$1} - #{$2} #{$3} - #{$4} - #{$5} - #{$6} - #{$7} - #{$8} - #{$9}"
      end
    end
    respond_to do |format|
      # if @extract_payment.save
        format.html { redirect_to extract_weeklies_path, :notice => 'Extract payment was successfully created.' }
      # end
    end
  end  
  
  def list_extract_weekly
    @per_ini = params[:period_initial].to_datetime
    @per_fim = params[:period_final].to_datetime  
    
    # sql = "select id, user_id, name, registration, series, proposal, code_beneficiary, plan, number_quota, value_contribution, commission_percentage, commission_value, period_initial, perido_final from extract_monthlies where period_initial = " + '"#{per_ini}"' + " and perido_final = '2012/03/08' group by id, user_id, name, registration, series, proposal, code_beneficiary, plan, number_quota, value_contribution, commission_percentage, commission_value, period_initial, perido_final ORDER BY id"
    # @extract_monthlies = ExtractMonthly.find_by_sql(sql)
    @consolidates = Consolidate.select("id, user_id, name, registration, series, proposal, code_beneficiary, plan, number_quota, value_contribution, commission_percentage, commission_value, period_initial, period_final").where("period_initial = '#{@per_ini}' and period_final = '#{@per_fim}'").group("id, user_id, name, registration, series, proposal, code_beneficiary, plan, number_quota, value_contribution, commission_percentage, commission_value, period_initial, period_final").order("id").all
    @extract_payment_weeklies = ExtractWeekly.select("id, user_id, name, registration, series, proposal, code_beneficiary, plan, number_quota, value_contribution, commission_percentage, commission_value, period_initial, period_final").where("period_initial = '#{@per_ini}' and period_final = '#{@per_fim}'").group("id, user_id, name, registration, series, proposal, code_beneficiary, plan, number_quota, value_contribution, commission_percentage, commission_value, period_initial, period_final").order("id").all
    if @extract_payment_weeklies.count == 0
      flash[:notice] = "Nenhum arquivo importado para o Movimento Mensal!"
    end
    respond_to do |format|
      format.html # index.html.erb
      # format.json { render json: @extract_monthlies }
    end
  end
end
