class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.valid_password(params[:password])
      # session.clear
      sessions[:user_id] = @user.id
      redirect_to "/welcome"
    else
      redirect_to "/login", notice: "echec"
    end
  end

  def login
  end

  def welcome
  end
end
