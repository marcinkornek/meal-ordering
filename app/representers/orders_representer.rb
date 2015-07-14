require 'representable/json/collection'

module OrdersRepresenter
  include Representable::JSON::Collection

  items extend: OrderRepresenter
end
