class Api::UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: current_user.extend(UserRepresenter)
  end
end
