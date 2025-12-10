class UsersController < ApplicationController

  skip_before_action :authenticate_user!, only: [:new, :create, :index, :show]
  
  before_action :set_user, only: %i[ show edit update destroy ]


  def index
    @users = User.all
  end


  def show
  end

 
  def new
    @user = User.new
  end


  def edit
  end

 
  def create
   
    @submitted_params = params[:user]
    
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
      
        session[:registration_params] = @submitted_params
        format.html { redirect_to registration_params_users_path, notice: "Акаунт успішно створено! Вітаємо, #{@user.nickname}! Ваш баланс: #{@user.balance}₴" }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def registration_params
    @params_data = session[:registration_params] || {}
    @user = current_user 
    session.delete(:registration_params) 
  end

 
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_path, notice: "User was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
   
    def set_user
      @user = User.find(params[:id])
    end

  
    def user_params
      if action_name == 'create'
      
        params.require(:user).permit(:nickname, :email, :full_name)
      else
        params.require(:user).permit(:nickname, :email, :full_name, :balance)
      end
    end
end
