class Api::OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    orders = current_user.consumers.map(&:order)
    render json: orders
  end

  def create
    order = Order.new(order_params)
    if order.save
      render json: order
    else
      render json: order.errors, status: :not_acceptable
    end
  end

  private

  def order_params
    params.require(:order).permit(:consumer_id, :product_name, :price)
  end
end
