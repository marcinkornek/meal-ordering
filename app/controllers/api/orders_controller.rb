class Api::OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    remaining_consumers_count = Consumer.remaining_consumers(current_user.consumers).count
    render json: {
      orders: current_user.orders.includes(:consumer).extend(OrdersRepresenter).to_hash,
      remaining_consumers_count: remaining_consumers_count,
      consumers_count: current_user.consumers.count
    }
  end

  def show
    render json: order.extend(OrderRepresenter)
  end

  def create
    order = Order.new(order_params)
    if order.save
      render json: order.extend(OrderRepresenter)
    else
      render json: order.errors, status: :not_acceptable
    end
  end

  def update
    if order.update_attributes(order_params)
      render json: order.extend(OrderRepresenter)
    else
      render json: order.errors, status: :not_acceptable
    end
  end

  def destroy
    render json: order.destroy
  end

  def deliver
    order.deliver!
    render json: order.extend(OrderRepresenter)
  end

  private

  def order
    @order ||= current_user.orders.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:consumer_id, :product_name, :price)
  end
end
