class Consumer < ActiveRecord::Base
  has_one :order, dependent: :destroy
  belongs_to :user

  validates :user,       presence: true
  validates :first_name, presence: true
  validates :last_name,  presence: true

  def self.remaining_consumers(consumers)
    consumers.joins('LEFT JOIN orders ON orders.consumer_id = consumers.id')
             .where('orders.consumer_id IS NULL')
  end
end
