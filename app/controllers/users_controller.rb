class UsersController < ApplicationController
  wrap_parameters format: []
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  skip_before_action :authorized, only: :create
  

  def show
    user = User.find_by(id: session[:user_id])
    if user 
      render json: user
    else
      render json: {error: 'Not Authorized'}, status: :unauthorized
    end
  end

  def create
    user = User.create(user_params)
    session[:user_id] = user.id
    render json: user, status: :created
  end

  private

  def user_params
    params.permit(:username, :password, :password_confirmation)
  end

  def render_unprocessable_entity
    render json: {error: invalid.record.errors}, status: :unprocessable_entity    
  end

end
