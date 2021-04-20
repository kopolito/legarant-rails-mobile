class UsersController < ApplicationController
  before_action :authorize, except: %i[ new create ]
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

    # GET /users/1 or /users/1.json
  def show
    #@contracts = @user.contracts
  end

  # GET /users/new
  def new
    if logged_in?
      respond_to do |format|
        format.html { redirect_to '/welcome' }
        format.json { head :no_content }
      end
    end
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    if logged_in?
      respond_to do |format|
        format.html { redirect_to '/welcome' }
        format.json { head :no_content }
      end
    end
    ok = false
    result = ""
    @user_params = user_params
    Rails.logger.debug "PARAMS : #{@user_params}"
    @user = User.where({ email: @user_params[:email] }).last
    
    if @user.nil?
      result = "created"
      password = @user_params[:encrypted_password__c]
      Rails.logger.debug "PASS : #{password}"
      @user_params[:encrypted_password__c] = User.hash_password(password)
      @user_params[:extid__c] = @user_params[:encrypted_password__c]
      @user = User.new(user_params)
      ok = @user.save
    elsif  @user.encrypted_password__c.nil?
      result = "updated"
      @user_params[:encrypted_password__c] = User.hash_password(@user_params[:encrypted_password__c])
      ok = @user.update(@user_params)
    else
      ok = false
      result = "An account with this email exists."
    end

    respond_to do |format|
      if ok
        session[:user_id] = @user.id
        format.html { redirect_to '/welcome', notice: "User was successfully #{result}" }
        format.json { render :show, status: :created, location: @user }
      else
        flash[:notice] = result
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # def create
  #    @user = User.create(params.require(:user).permit(:username,
  #    :password))
  #    session[:user_id] = @user.id
  #    redirect_to '/welcome'
  # end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    ok = false
    result = ""
    @user_params = user_params
    password = @user_params[:encrypted_password__c]
    Rails.logger.debug "PASSWORD #{password}"
    if @user.valid_password(password)
      Rails.logger.debug "VALID PASSWORD"
      @user_params[:encrypted_password__c] = User.hash_password(password)
      if @user.update(@user_params)
        ok = true
        result = "Profile was successfully updated."
      else
        result = "Impossible to update profile"
      end
    else
      Rails.logger.debug "INVALID PASSWORD"
      result = "Please confirm your password"
    end

    respond_to do |format|
      if ok
        format.html { redirect_to @user, notice: result }
        format.json { render :show, status: :ok, location: @user }
      else
        flash[:notice] = result
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # # DELETE /users/1 or /users/1.json
  # def destroy

  #   @user.destroy
  #   respond_to do |format|
  #     format.html { redirect_to users_url, notice: "User was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    @user_params ||= params.require(:user).permit(:firstname, :lastname, :email, :phone, :mobilephone, :mailingcity, :mailingcountry, :mailingpostalcode, :mailingstate, :mailingstreet, :encrypted_password__c)
  end
end
