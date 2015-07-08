class Api::SessionsController < ApplicationController
  def oauth
    user = User.find_for_oauth(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    session.clear
    render json: {token: form_authenticity_token}
  end
end
