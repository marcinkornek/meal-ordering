module UserRepresenter
  include Roar::JSON

  property :id
  property :email
  property :first_name
  property :last_name
  property :role
  property :full_name
  property :consumers_count
  property :created_at

  def full_name
    "#{first_name} #{last_name}"
  end

  def consumers_count
    consumers.size
  end
end
