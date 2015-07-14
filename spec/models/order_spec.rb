require 'rails_helper'

describe Order do
  let!(:order) { FactoryGirl.create(:order) }

  it { expect(order).to respond_to(:state) }
  it { expect(order).to respond_to(:product_name) }
  it { expect(order).to respond_to(:price) }
  it { expect(order).to respond_to(:consumer) }

  it { expect(order).to be_valid }

  describe 'when product_name' do
    context 'is not present' do
      before { order.product_name = '' }
      it { expect(order).not_to be_valid }
    end
  end

  describe 'when price' do
    context 'is not present' do
      before { order.price = '' }
      it { expect(order).not_to be_valid }
    end

    context 'is not a number' do
      before { order.price = 'aa' }
      it { expect(order).not_to be_valid }
    end

    context 'is 0' do
      before { order.price = 0 }
      it { expect(order).not_to be_valid }
    end

    context 'is smaller than 0' do
      before { order.price = -1 }
      it { expect(order).not_to be_valid }
    end
  end

  describe 'when consumer' do
    context 'is not present' do
      before { order.consumer = nil }
      it { expect(order).not_to be_valid }
    end
  end

  describe '#delivered' do
    context 'change state to delivered' do
      before { order.delivered }

      it { expect(order.state).to eq('delivered') }
    end
  end
end
