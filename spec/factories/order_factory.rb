FactoryGirl.define do
  factory :order do
    state 'ordered'
    product_name 'product name'
    price '9.99'
    consumer
  end
end
