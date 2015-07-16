require 'rails_helper'

describe Api::OrdersController do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:consumer)       { FactoryGirl.create(:consumer, first_name: 'Adam', last_name: 'Aaa', user: user) }
  let!(:other_consumer) { FactoryGirl.create(:consumer, first_name: 'Bartek', last_name: 'Bbb', user: user) }
  let!(:consumer_order) { FactoryGirl.create(:order, consumer: consumer) }
  let(:order_representer) do
    {
      'orders' => [consumer_order.extend(OrderRepresenter).to_hash],
      'remaining_consumers_count' => 1,
      'consumers_count' => 2
    }.to_json
  end

  context 'user is logged in' do
    before do
      allow(controller).to receive(:logged_in?).and_return(true)
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe 'GET index' do
      it 'returns JSON with all orders' do
        get :index
        expect(response.body).to eq(order_representer)
      end
    end

    describe 'GET show' do
      it 'returns JSON with order' do
        get :show, {id: consumer_order.id}
        expect(response.body).to eq(consumer_order.extend(OrderRepresenter).to_json)
      end
    end

    describe 'POST create' do
      let(:post_create) do
        post :create, { order: { consumer_id: consumer.id, product_name: 'product name', price: 10 } }
      end

      it 'creates a new consumer' do
        expect { post_create }.to change{ Order.count }.by(1)
      end

      it 'returns JSON with created consumer' do
        post_create
        expect(JSON.parse(response.body)['product_name']).to eq('product name')
        expect(JSON.parse(response.body)['price']).to eq('10.0')
      end
    end

    describe 'DELETE destroy' do
      let(:delete_destroy) { delete :destroy, { id: consumer_order.id } }

      it 'destroys a consumer' do
        expect { delete_destroy }.to change{ Order.count }.by(-1)
      end

      it 'returns JSON with deleted consumer' do
        delete_destroy
        expect(JSON.parse(response.body)['product_name']).to eq(consumer_order.product_name)
        expect(JSON.parse(response.body)['price']).to eq(consumer_order.price.to_s)
      end
    end
  end
end
