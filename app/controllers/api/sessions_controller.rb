class Api::SessionsController < ApplicationController
  def create
    user = User.find_for_oauth(session_params)
    session[:user_id] = user.id
    if user
      render json: user.extend(HeaderUserRepresenter)
    else
      render json: user.errors, status: :not_acceptable
    end
  end

  def destroy
    session.clear
    render json: {token: form_authenticity_token}
  end

  private

  def session_params
    params.require(:session).permit(:first_name, :last_name, :email, :id, :provider)
  end
end
