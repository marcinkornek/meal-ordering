require 'rails_helper'

describe Consumer do
  let!(:consumer) { FactoryGirl.create(:consumer) }

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
end
