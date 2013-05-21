class ConsolidateController < ApplicationController
  def index
    @consolidates = Consolidate.select("extract(MONTH FROM period_initial) AS month, extract(YEAR FROM period_initial) AS year").where("user_id = #{current_user.id}").group("extract(MONTH FROM period_initial), extract(YEAR FROM period_initial)")
    puts @consolidates.to_sql
    respond_to do |format|
      format.html # index.html.erb
    end

  end

  def show
  end

  def select_period_consolidate

  end

  def consolidate
    # month_reference = "0" + params[:month_reference] if params[:month_reference].to_i < 10
    month_reference = params[:month_reference] 
    year_reference = params[:year_reference]   
    month_year = []
    
    periods = []
    periods = ExtractMonthly.select("distinct EXTRACT(MONTH FROM period_initial) AS month, EXTRACT(YEAR FROM period_initial) AS year").where("extract(MONTH FROM period_initial) > #{month_reference} and extract(YEAR FROM period_initial) >= #{year_reference}").order("month, year").all.map{|p|[p.month.to_i,p.year.to_i]}
    
    arr_proposal = []
    
    cod_proposal = 0
    cod_series = 0
    
    
    @extract_monthly = ExtractMonthly.select("*").where("extract(MONTH FROM period_initial) > #{month_reference} and extract(YEAR FROM period_initial) >= #{year_reference}").order("series, proposal, extract(MONTH FROM period_initial), extract(YEAR FROM period_initial)")
    cod_proposal = @extract_monthly.first.proposal
    cod_series = @extract_monthly.first.series 
    @extract_monthly.each do |ext|  
      
      if cod_series == ext.series and cod_proposal == ext.proposal
        month_year << [ext.period_initial.strftime("%m").to_i, ext.period_initial.strftime("%Y").to_i] 
        cod_proposal = ext.proposal
        cod_series = ext.series
      # else
      #   puts "nao e igual"  
      #   m = []
      #   m = month_year.uniq.sort  
      #   unless m.blank? 
      #     tot = m.length.to_i
      #     for i in 0..tot-1
      #       m << [m[i][0] -1,m[i][1]]
      #     end
      #   end
      end  
      
      # Inicio do comentário do código que esta correto
      
      
      # if ext.proposal == 1885396 #1885396  #857410
      #   month_year << [ext.period_initial.strftime("%m").to_i, ext.period_initial.strftime("%Y").to_i] 
      # end  
      
      # Final do comentário do código que esta correto
      
    end  
    # Inicio do comentário do código que esta correto
    
    m = []
    m = month_year.uniq.sort  
    x = periods-m
    puts "ppppppppppppppppp"
    puts x
    puts "ppppppppppppppppp"
    
    # unless m.blank? 
    #   tot = m.length.to_i
    #   for i in 0..tot-1
    #     m << [m[i][0] -1,m[i][1]]
    #   end
    # end   
    # puts "------------------------"
    # puts month_year.uniq.sort  
    # puts "------------------------"
    # x = periods-m
    # puts "***************" 
    # puts cod_proposal
    # puts cod_series
    # puts x 
    # puts "acabou"
    # puts periods
    # puts m
    # puts "***************"   
    
    # Final do comentário do código que esta correto
    
    
    # puts m    
    
    
    # puts month_year.uniq.sort
    # puts "***************"
    # puts periods
    
    # @extract_monthly_reference.each do |item| 
    #   @period.each do |period| 
    #     @extract_monthly = ExtractMonthly.select("*").where("extract(MONTH FROM period_initial) = #{period.month} and extract(YEAR FROM period_initial) = #{period.year} and proposal = #{item.proposal} and series = #{item.series}")
    #     if item.proposal == 1885396  
    #       unless arr_month_year.include?([period.month,period.year]) 
    #         arr_month_year << [period.month,period.year]
    #       end
    #     end
    #   end
      # arr_proposal = @extract_monthly_reference.where(:series => extract_monthly.series, :proposal => extract_monthly.proposal, :number_quota => extract_monthly.number_quota)
      # 
      # 
      # 
      # 
      # 
      # @period.each do |period| 
      #   @extract_monthly = ExtractMonthly.select("*").where("extract(MONTH FROM period_initial) = #{period.month} and extract(YEAR FROM period_initial) = #{period.year} and proposal = #{item.proposal} and series = #{item.series}")
      #   
      #   arr_proposal = @extract_monthly.where(:series => extract_monthly.series, :proposal => extract_monthly.proposal, :number_quota => extract_monthly.number_quota)
      #   if @extract_monthly.length == 0
      #   else    
      #   end  
      # end  
    
    
    
    # @period.each do |period| 
    #   @extract_monthly = ExtractMonthly.select("*").where("extract(MONTH FROM period_initial) = #{period.month} and extract(YEAR FROM period_initial) = #{period.year} and proposal = #{item.proposal} and series = #{item.series}")     
    #   @extract_monthly.each do |item|
    #     if item.proposal == 1885396 
    #       # @extract_monthly = ExtractMonthly.select("*").where("extract(MONTH FROM period_initial) = #{period.month} and extract(YEAR FROM period_initial) = #{period.year} and proposal = #{item.proposal} and series = #{item.series}")     
    #       # if @extract_monthly.length == 0
    #       #   puts "mes e ano em atraso = #{period.month} - #{period.year}"
    #       # else
    #       #   puts "mes e ano em dia = #{period.month} - #{period.year}"
    #       # end     
    #     end
    #   end  
    # end
    
    
    
    # @extract_monthly_reference.each do |item|
    #   @period.each do |period| 
    #     if item.proposal == 1885396 
    #       @extract_monthly = ExtractMonthly.select("*").where("extract(MONTH FROM period_initial) = #{period.month} and extract(YEAR FROM period_initial) = #{period.year} and proposal = #{item.proposal} and series = #{item.series}")     
    #       if @extract_monthly.length == 0
    #         puts "mes e ano em atraso = #{period.month} - #{period.year}"
    #       else
    #         puts "mes e ano em dia = #{period.month} - #{period.year}"
    #       end     
    #     end
    #   end
    # end  
    
    
    
    
    
    
      # if item.proposal == 1885396
      #   proposal = @extract_monthly_reference.where(:series => item.series, :proposal => item.proposal)
      #   if proposal.length > 1
      #     puts "E maior que 1"
      #     
      #     unless arr_proposal.include?([item.series, item.proposal, item.number_quota])
      #       proposal.each do |p|
      #         arr_proposal << [item.series, item.proposal, item.number_quota]
      #       end
      #     end
      #   else 
      #     puts "Entrei aqui"
      #     arr_proposal << [item.series, item.proposal, item.number_quota]
      #   end
      # end  
      # @period.each do |p|
      #   # @extract_monthly = ExtractMonthly.select("*").where("extract(MONTH FROM period_initial) = #{p.month} and extract(YEAR FROM period_initial) = #{p.year} and series = #{item.series} and proposal = #{item.proposal} and plan = #{item.plan}")  
      #   @extract_monthly = ExtractMonthly.select("*").where("extract(MONTH FROM period_initial) = #{p.month} and extract(YEAR FROM period_initial) = #{p.year} and series = 59 and proposal = 1885396")  
      #   @extract_monthly.each do |extract_monthly|
      #     if extract_monthly.proposal == 1885396
      #       proposal = @extract_monthly.where(:series => extract_monthly.series, :proposal => extract_monthly.proposal)
      #       if proposal.length > 1
      #         unless arr_proposal.include?([extract_monthly.series, extract_monthly.proposal, item.number_quota])
      #           proposal.each do |p|
      #             arr_proposal << [extract_monthly.series, extract_monthly.proposal, extract_monthly.number_quota]
      #           end
      #         end
      #       else
      #         arr_proposal << [extract_monthly.series, extract_monthly.proposal, extract_monthly.number_quota]
      #       end
      #     end
      #   end
      # end
    # end
    # puts "**********************************"
    # puts arr_proposal  
    # puts "**********************************"
      
      # proposal = @extract_monthly.where(:proposal => item.proposal, :series => item.series)
      # if proposal.length > 1 
      #   unless arr_proposal.include?([item.proposal, item.series])
      #     arr_proposal << [item.proposal, item.series]  
      #     
      #   end
      #   puts "************************************"
      #   proposal.each do |p|  
      #     puts "Nome Arquivo: #{p.name}"
      #     puts "Proposta: #{p.proposal}"
      #     puts "Series: #{p.series}"
      #     puts "Parcela: #{p.number_quota}"
      #     puts "Plano: #{p.plan}"
      #     parcel << p.number_quota    
      #   end  
      #   puts "************************************"   
      #   
      # else
      #   parcel << item.number_quota    
      # end
        
      # @period.each do |p|
      #   @extract_monthly = ExtractMonthly.select("*").where("extract(MONTH FROM period_initial) = #{p.month} and extract(YEAR FROM period_initial) = #{p.year} and series = #{item.series} and proposal = #{item.proposal} and plan = #{item.plan}")     
      #   proposal = @extract_monthly.where(:proposal => item.proposal, :series => item.series, :plan => item.plan)
      #   if proposal.length > 1
      #     proposal.each do |p|  
      #       parcel << p.number_quota
      #     end
      #   else
      #     parcel << item.number_quota    
      #   end
      # end
      # if parcel.count < @period.count + 1
      #   puts "Proposta: #{item.proposal} - Series: #{item.series} - Plano: #{item.plan}"   
      #   
      # end
    # end
    
    
    # @period.each do |period|
    #   @extract_monthly = ExtractMonthly.select("*").where("extract(MONTH FROM period_initial) = #{period.month} and extract(YEAR FROM period_initial) = #{period.year}") 
    #   @extract_monthly.each do |item|
    #     proposal = @month_year_reference.where(:proposal => item.proposal, :series => item.series, :plan => item.plan)
    #     if proposal.length == 1
    #     end
    #   end
    # end                                                        
    
    
    # @extract_monthly = ExtractMonthly.select("*").where("extract(MONTH FROM period_initial) = #{month_ref} and extract(YEAR FROM period_initial) = #{year_ref}")
    # @month_year_reference.each do |month_year_reference|
    #   proposal = @month_year_reference.where(:proposal => month_year_reference.proposal, :series => month_year_reference.series, :plan => month_year_reference.plan)
    #   if proposal.length > 1  
    #     
    #     # unless array_month_year.include?([month_year_reference.series, month_year_reference.proposal, month_year_reference.plan])
    #     #   array_month_year << [month_year_reference.series, month_year_reference.proposal, month_year_reference.plan]
    #     #   proposal.each do |p|  
    #     #     parcel << p.number_quota    
    #     #   end
    #     # end
    #     # total_proposal = proposal.count  
    #     
    #     
    #     
    #     
    #     
    #   else 
    #     # @total_months_after_reference.each do |total_months_after_reference|
    #     #   @months_after_reference =  ExtractMonthly.select("*").where("series = #{month_year_reference.series} and proposal = #{month_year_reference.proposal} and number_quota = #{parcel} and extract(MONTH FROM period_initial) = #{month_year[0]} and extract(YEAR FROM period_initial) = #{month_year[1]}")  
    #     # end
    #     # @consolidate_extract_monthlies =  ExtractMonthly.select("*").where("series = #{item.series} and proposal = #{item.proposal} and number_quota = #{parcel} and extract(MONTH FROM period_initial) = #{month_year[0]} and extract(YEAR FROM period_initial) = #{month_year[1]}")  
    #     # @consolidate_extract_monthlies =  ExtractMonthly.select("*").where("series = #{item.series} and proposal = #{item.proposal} and number_quota = #{parcel} and extract(MONTH FROM period_initial) = #{month_year[0]} and extract(YEAR FROM period_initial) = #{month_year[1]}")
    #     # puts total_proposal
    #     # unless array_month_year.include?(month_year_reference.proposal)
    #     #   array_month_year << [month_year_reference.proposal]
    #     #   puts "passei"
    #     #   # proposal.each do |p|
    #     #   #   puts p.proposal
    #     #   #   puts p.number_quota
    #     #   # end
    #     # end
    #   end
    #   # array_month_year.each do |arr|
    #   #   puts arr
    #   # end
    # end

    # @month_year_reference.each do |month_year_reference|
    #   @months_after_reference = ExtractMonthly.select("*").where("extract(MONTH FROM period_initial) > #{month_ref} and extract(YEAR FROM period_initial) >= #{year_ref} and series = #{month_year_reference.series} and proposal = #{month_year_reference.proposal}")
    #   if @months_after_reference.length != @total_months_after_reference.length
    #     puts @months_after_reference.inspect
    #   end
    # end




    @import = Consolidate.all
  end

  def consolidate_old
    array_month_year = []
    month_ref = "0" + params[:month_reference] if params[:month_reference].to_i < 10
    year_ref = params[:year_reference]
    dt = "05-" + month_ref + "-" + year_ref
    day_total = 30
    dt_initial = dt.to_datetime+30
    for i in 1..6
      if i == 1
        array_month_year << [dt_initial.month, dt_initial.year]
      else
        day_total = day_total + 30
        dt_initial = dt.to_datetime+day_total
        array_month_year << [dt_initial.month, dt_initial.year]
      end
    end
    @import = ExtractMonthly.all
    @consolidate_extract_weeklies = ExtractWeekly.select("*").where("extract(MONTH FROM period_initial) = #{month_ref} and extract(YEAR FROM period_initial) = #{year_ref}")
    @consolidate_extract_weeklies.each do |item|
      reg_ok = false
      parcel = item.number_quota + 1
      array_month_year.each do |month_year|
        parcel = item.number_quota + 1
        @consolidate_extract_monthlies =  ExtractMonthly.select("*").where("series = #{item.series} and proposal = #{item.proposal} and number_quota = #{parcel} and extract(MONTH FROM period_initial) = #{month_year[0]} and extract(YEAR FROM period_initial) = #{month_year[1]}")
        if @consolidate_extract_monthlies.count > 0
          reg_ok = true
          break
        end
      end
      if !reg_ok
        consolidation = Consolidate.new(:user_id => current_user.id,
                                        :name => item.name,
                                        :registration => item.registration,
                                        :series => item.series,
                                        :proposal => item.proposal,
                                        :code_beneficiary => item.code_beneficiary,
                                        :plan => item.plan,
                                        :number_quota => item.number_quota,
                                        :value_contribution => item.value_contribution,
                                        :commission_percentage => item.commission_percentage,
                                        :commission_value => item.commission_value,
                                        :period_initial => item.period_initial,
                                        :period_final => item.period_final)
        consolidation.save
      end
    end
    @import = Consolidate.all
  end
end
