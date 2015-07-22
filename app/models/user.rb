class User < ActiveRecord::Base
  has_many :consumers, dependent: :destroy
  has_many :orders, through: :consumers

  validates :email,      presence: true, uniqueness: {case_sensitive: false}
  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :uid,        presence: true
  validates :provider,   presence: true

  def self.find_for_oauth(params)
    user = User.find_by(provider: params[:provider], uid: params[:id])
    user || create_user_with_aouth(params)
  end

  private

  def self.create_user_with_aouth(params)
    User.create(
      email: params[:email],
      first_name: params[:first_name],
      last_name: params[:last_name],
      uid: params[:id],
      provider: params[:provider]
    )
  end
end
