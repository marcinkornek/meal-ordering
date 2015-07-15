require 'rails_helper'

describe Api::UsersController do
  let!(:user) { FactoryGirl.create(:user) }

  context 'user is logged in' do
    before do
      allow(controller).to receive(:logged_in?).and_return(true)
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe 'GET show' do
      it 'returns JSON with user' do
        get :show, {id: user.id}
        expect(response.body).to eq(user.to_json)
      end
    end
  end
end
