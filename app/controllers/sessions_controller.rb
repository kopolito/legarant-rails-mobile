class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.where({ email: params[:email] }).last

    if @user
      Rails.logger.debug "### $$$$$$$$$$$$$$$$$$$$$$$"
      Rails.logger.debug "### login : #{@user}"
      # Rails.logger.debug "hash : #{@user.hash_password(params[:password])}"
      # Rails.logger.debug "orig : #{@user.encrypted_password__c.length}"
      # Rails.logger.debug "email : #{@user.email}"
      # Rails.logger.debug "firstname : #{@user.firstname}"
      
      if @user.encrypted_password__c.nil?
        Rails.logger.debug "### must create account :"
        redirect_to "/users/new", notice: "Please create an account"
      elsif @user.valid_password(params[:password])
        Rails.logger.debug "### OK LOGGED :"
        # session.clear
        session[:user_id] = @user.id
        redirect_to @user
      else
        Rails.logger.debug "### BAD PASS"
        redirect_to "/login", notice: "Email or password incorrect"
      end
    else
      Rails.logger.debug "### USER NOT FOUND"
      redirect_to "/login", notice: "Email or password incorrect"
    end
  end

  def login
  end

  def welcome
    if logged_in?
      @user = User.find(session[:user_id])
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/welcome', notice: "Logged out!"
  end

  def edit
  end

  def update
    @user = current_user
    if !@user.valid_password(params[:password])
      respond_to do |format|
        flash[:notice] = "Please confirm your password"
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    else 
      @user.encrypted_password__c = User.hash_password(params[:password])
      respond_to do |format|
        if @user.save
          format.html { redirect_to @user, notice: "Password updated" }
          format.json { render :show, status: :ok, location: @user }
        else
          flash[:notice] = "Could not update password"
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end
end
