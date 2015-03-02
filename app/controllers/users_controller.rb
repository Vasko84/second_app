class UsersController < ApplicationController
  before_action :signed_in_users, only: [:edit, :update]
  def show
    @user=User.find(params[:id])  
  end
  
  def new
    @user=User.new
  end
  
  def create
    @user=User.new(user_params) #not final
    if @user.save
      sign_in(@user)
      flash[:success]= "Welcome to the Second App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user=User.find(params[:id])
  end
  
  def update
    @user=User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  
  def signed_in_users
    unless signed_in?
      flash[:warning]="Please sign in." 
      redirect_to signin_url
    end
  end
  
end
