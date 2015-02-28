module SessionsHelper
  def sign_in
    remember_token=User.new_remember_token
    cookies.permanent[:remember_token]=remember.token
    user.update_attributes(:remember_token, User.encrypt(remember_token))
    self.current_user=user      
  end
    
  def current_user=(user)
    @current_user=user
  end
  
end
