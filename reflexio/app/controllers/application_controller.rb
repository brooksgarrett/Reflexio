class ApplicationController < ActionController::Base
  before_filter :instantiateUser

  def instantiateUser
    @user = User.new
  end
  protect_from_forgery

end
