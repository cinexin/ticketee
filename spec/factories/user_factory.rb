FactoryGirl.define do
  factory :user do
    name "Example user"
    email "An example user, nothing more, nothing less"
    password "sample_password"
    password_confirmation "sample_password"
  end
end