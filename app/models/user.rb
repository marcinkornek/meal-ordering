class User < ActiveRecord::Base
  validates :email,      presence: true,
                         uniqueness: {case_sensitive: false}
  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :uid,        presence: true
  validates :provider,   presence: true

  def self.find_for_oauth(auth)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    if user
      p '--------- already registered with oauth -----------'
      user
    else
      p '--------- creating user with oauth -----------'
      create_user_with_aouth(auth)
    end
  end

  private

  def self.create_user_with_aouth(auth)
    User.create(
      email: auth.info.email,
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      uid: auth.uid,
      provider: auth.provider,
    )
  end
end
