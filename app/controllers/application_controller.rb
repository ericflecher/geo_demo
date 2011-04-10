class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def get_user_by_id(user_id)
    User.first(:conditions => {:id => user_id})
  end
end
