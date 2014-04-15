FactoryGirl.define do
  factory :user do
    name "Example user"
    email "sample@example.com"
    password "sample_password"
    password_confirmation "sample_password"
  end
end