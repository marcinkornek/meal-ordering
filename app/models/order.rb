class Order < ActiveRecord::Base
  belongs_to :consumer

  validates :consumer,     presence: true
  validates :product_name, presence: true
  validates :price,        numericality: {greater_than: 0}
end
