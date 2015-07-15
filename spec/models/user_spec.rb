require 'rails_helper'

describe User do
  let!(:user)     { FactoryGirl.create(:user) }
  let!(:consumer) { FactoryGirl.create(:consumer, user: user) }
  let!(:other_consumer) { FactoryGirl.create(:consumer, user: user) }
  let!(:consumer_order) { FactoryGirl.create(:order, consumer: consumer) }
  let!(:other_consumer_order) { FactoryGirl.create(:order, consumer: other_consumer) }

  it { expect(user).to respond_to(:email) }
  it { expect(user).to respond_to(:first_name) }
  it { expect(user).to respond_to(:last_name) }
  it { expect(user).to respond_to(:provider) }
  it { expect(user).to respond_to(:uid) }

  it { expect(user).to be_valid }

  describe 'when email' do
    context 'is not present' do
      before { user.email = '' }
      it { expect(user).not_to be_valid }
    end

    context 'is already taken' do
      before do
        user_with_same_email = user.dup
        user_with_same_email.save
        user.save
      end
      it { should_not be_valid }
    end
  end

  describe 'when first_name' do
    context 'is not present' do
      before { user.first_name = '' }
      it { expect(user).not_to be_valid }
    end
  end

  describe 'when last_name' do
    context 'is not present' do
      before { user.last_name = '' }
      it { expect(user).not_to be_valid }
    end
  end

  describe 'when uid' do
    context 'is not present' do
      before { user.uid = '' }
      it { expect(user).not_to be_valid }
    end
  end

  describe 'when provider' do
    context 'is not present' do
      before { user.provider = '' }
      it { expect(user).not_to be_valid }
    end
  end

  describe '#orders' do
    it 'returns user customers orders' do
      expect(user.orders).to eq([consumer_order, other_consumer_order])
    end
  end
end
