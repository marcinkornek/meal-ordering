class Api::OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    orders = current_user.consumers.map(&:order).compact
    render json: orders.extend(OrdersRepresenter)
  end

  def create
    order = Order.new(order_params)
    if order.save
      render json: order.extend(OrderRepresenter)
    else
      render json: order.errors, status: :not_acceptable
    end
  end

  private

  def order_params
    params.require(:order).permit(:consumer_id, :product_name, :price)
  end
end
