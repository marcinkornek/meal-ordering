require 'rails_helper'

describe Consumer do
  let!(:user)           { FactoryGirl.create(:user) }
  let!(:consumer)       { FactoryGirl.create(:consumer, first_name: 'Adam', last_name: 'Aaa', user: user) }
  let!(:other_consumer) { FactoryGirl.create(:consumer, first_name: 'Bartek', last_name: 'Bbb', user: user) }
  let!(:consumer_order) { FactoryGirl.create(:order, consumer: consumer) }

  it { expect(consumer).to respond_to(:first_name) }
  it { expect(consumer).to respond_to(:last_name) }
  it { expect(consumer).to respond_to(:user) }

  it { expect(consumer).to be_valid }

  describe 'when first_name' do
    context 'is not present' do
      before { consumer.first_name = '' }
      it { expect(consumer).not_to be_valid }
    end
  end

  describe 'when last_name' do
    context 'is not present' do
      before { consumer.last_name = '' }
      it { expect(consumer).not_to be_valid }
    end
  end

  describe 'when user' do
    context 'is not present' do
      before { consumer.user = nil }
      it { expect(consumer).not_to be_valid }
    end
  end

  describe '#self.remaining_consumers' do
    it 'returns customers without orders' do
      expect(Consumer.remaining_consumers(user.consumers)).to eq([other_consumer])
    end
  end
end
