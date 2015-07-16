require 'rails_helper'

describe Api::ConsumersController do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:consumer)       { FactoryGirl.create(:consumer, first_name: 'Adam', last_name: 'Aaa', user: user) }
  let!(:other_consumer) { FactoryGirl.create(:consumer, first_name: 'Bartek', last_name: 'Bbb', user: user) }
  let(:consumer_representer) do
    {
      'id' => consumer.id,
      'first_name' => consumer.first_name,
      'last_name' => consumer.last_name,
      'created_at' => consumer.created_at
    }.to_json
  end
  let(:consumers_representer) do
    [
      {
        'id' => consumer.id,
        'first_name' => consumer.first_name,
        'last_name' => consumer.last_name,
        'created_at' => consumer.created_at
      },
      {
      'id' => other_consumer.id,
      'first_name' => other_consumer.first_name,
      'last_name' => other_consumer.last_name,
      'created_at' => other_consumer.created_at
      }
    ].to_json
  end

  context 'user is logged in' do
    before do
      allow(controller).to receive(:logged_in?).and_return(true)
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe 'GET index' do
      it 'returns JSON with all consumers' do
        get :index
        expect(response.body).to eq(consumers_representer)
      end
    end

    describe 'GET show' do
      it 'returns JSON with consumer' do
        get :show, {id: consumer.id}
        expect(response.body).to eq(consumer_representer)
      end
    end

    describe 'POST create' do
      let(:post_create) { post :create, { consumer: FactoryGirl.attributes_for(:consumer) } }

      it 'creates a new consumer' do
        expect { post_create }.to change{ Consumer.count }.by(1)
      end

      it 'returns JSON with created consumer' do
        post_create
        expect(JSON.parse(response.body)['first_name']).to eq('name')
        expect(JSON.parse(response.body)['last_name']).to eq('surname')
      end
    end

    describe 'DELETE destroy' do
      let(:delete_destroy) { delete :destroy, { id: consumer.id } }

      it 'destroys a consumer' do
        expect { delete_destroy }.to change{ Consumer.count }.by(-1)
      end

      it 'returns JSON with deleted consumer' do
        delete_destroy
        expect(JSON.parse(response.body)['first_name']).to eq(consumer.first_name)
        expect(JSON.parse(response.body)['last_name']).to eq(consumer.last_name)
      end
    end
  end
end
