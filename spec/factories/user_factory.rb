FactoryGirl.define do
  factory :user do
    first_name 'first'
    last_name  'last'
    email      'email@email.com'
    uid        'uid'
    provider   'facebook'
  end
end
