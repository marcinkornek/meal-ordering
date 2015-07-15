require 'rails_helper'

describe Api::SessionsController do
  let(:session) do
    {
      first_name: 'user1',
      last_name: 'lastname1',
      email: 'email@emai.com',
      id: '12312312312312',
      provider: 'facebook'
    }
  end

  describe 'POST create' do
    let(:post_create) { post :create, { session: session } }

    it 'creates a new session' do
      expect { post_create }.to change{ User.count }.by(1)
    end

    it 'returns JSON with created consumer' do
      post_create
      expect(JSON.parse(response.body)['email']).to eq(session[:email])
      expect(JSON.parse(response.body)['role']).to eq('user')
    end
  end

  describe 'DELETE destroy' do
    let(:delete_destroy) { delete :destroy, {} }

    it 'returns JSON with token' do
      delete_destroy
      expect(JSON.parse(response.body).keys.first).to eq('token')
    end
  end
end
