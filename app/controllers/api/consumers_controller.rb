class Api::ConsumersController < ApplicationController
  before_action :authenticate_user!

  def index
    consumers = current_user.consumers
    render json: consumers.includes(:order).extend(ConsumersRepresenter)
  end

  def show
    render json: consumer.extend(ConsumerRepresenter)
  end

  def create
    consumer = Consumer.new(consumer_params)
    consumer.user = current_user
    if consumer.save
      render json: consumer.extend(ConsumerRepresenter)
    else
      render json: consumer.errors, status: :not_acceptable
    end
  end

  def update
    if consumer.update_attributes(consumer_params)
      render json: consumer.extend(ConsumerRepresenter)
    else
      render json: consumer.errors, status: :not_acceptable
    end
  end

  def destroy
    render json: consumer.destroy
  end

  def remaining_consumers
    render json: Consumer.remaining_consumers(current_user.consumers)
  end

  private

  def consumer
    @consumer ||= current_user.consumers.find(params[:id])
  end

  def consumer_params
    params.require(:consumer).permit(:first_name, :last_name)
  end
end
