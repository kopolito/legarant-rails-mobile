class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    @user.encrypted_password__c = @user.hash_password(params.require(:user)[:password])

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id

        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
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
    @user_params = user_params
    password = params.require(:user)[:password]
    if !password.nil?
      @user_params[:encrypted_password__c] = @user.hash_password(password)
    end

    respond_to do |format|
      if @user.update(@user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    @user_params ||= params.require(:user).permit(:firstname, :lastname, :email, :phone, :mobilephone, :mailingcity, :mailingcountry, :mailingpostalcode, :mailingstate, :mailingstreet)
  end
end