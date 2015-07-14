class Consumer < ActiveRecord::Base
  has_one :order, dependent: :destroy
  belongs_to :user

  validates :user,       presence: true
  validates :first_name, presence: true
  validates :last_name,  presence: true
end
