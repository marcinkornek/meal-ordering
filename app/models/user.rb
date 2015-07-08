class User < ActiveRecord::Base
  validates :email,      presence: true,
                         uniqueness: {case_sensitive: false}
  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :uid,        presence: true
  validates :provider,   presence: true
end
