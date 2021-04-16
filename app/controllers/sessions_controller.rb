class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.where({ email: params[:email] }).last

    if @user
      Rails.logger.debug "$$$$$$$$$$$$$$$$$$$$$$$"
      Rails.logger.debug "user : #{@user}"
      Rails.logger.debug "hash : #{@user.hash_password(params[:password])}"
      Rails.logger.debug "orig : #{@user.encrypted_password__c.length}"
      Rails.logger.debug "email : #{@user.email}"
      Rails.logger.debug "firstname : #{@user.firstname}"

      if @user.valid_password(params[:password])
        # session.clear
        session[:user_id] = @user.id
        redirect_to "/welcome"
      end
    else
      redirect_to "/login", notice: "echec"
    end
  end

  def login
  end

  def welcome
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end
