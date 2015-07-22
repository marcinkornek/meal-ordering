module ConsumersRepresenter
  include Representable::JSON::Collection

  items extend: ConsumerRepresenter
end
