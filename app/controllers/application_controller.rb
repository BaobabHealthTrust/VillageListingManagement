class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery #with: :exception

  before_filter :aut, :except => ['login', 'logout','remote_login']

  private

  def aut
    if session[:user_id].blank? 
      if not params[:user].blank?
        user = User.find(params[:user]['username'])
        session[:user_id] = user.id 
      else
        respond_to do |format|
          format.html { redirect_to '/login' }
        end
      end
    end
  end

end
