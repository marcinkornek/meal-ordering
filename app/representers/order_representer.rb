module OrderRepresenter
  include Roar::JSON

  property :id
  property :state
  property :product_name
  property :price
  property :created_at
  property :consumer_name

  def consumer_name
    consumer.first_name + ' ' + consumer.last_name
  end
end
