class CreditsLogs < ActiveRecord::Base
  attr_accessible :new_credits, :new_plan_id, :previous_credits, :previous_plan_id, :user_id
end
