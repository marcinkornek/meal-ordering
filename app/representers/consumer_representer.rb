module ConsumerRepresenter
  include Roar::JSON

  property :id
  property :first_name
  property :last_name
  property :created_at
  property :order
end
