class Api::ConsumersController < ApplicationController
  before_action :authenticate_user!

  def index
    consumers = current_user.consumers
    render json: consumers
  end

  def show
    render json: consumer
  end

  def create
    consumer = Consumer.new(consumer_params)
    consumer.user = current_user
    if consumer.save
      render json: consumer
    else
      render json: consumer.errors, status: :not_acceptable
    end
  end

  def update
    if consumer.update_attributes(consumer_params)
      render json: consumer
    else
      render json: consumer.errors, status: :not_acceptable
    end
  end

  private

  def consumer
    @consumer ||= current_user.consumers.find(params[:id])
  end

  def consumer_params
    params.require(:consumer).permit(:first_name, :last_name)
  end
end
