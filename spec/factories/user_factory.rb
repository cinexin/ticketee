FactoryGirl.define do
	# user
	factory :user do
		name "Example user"
		email "sample@example.com"
		password "sample_password"
		password_confirmation "sample_password"

		  # admin user
		factory :admin_user do
			admin true
		end
	end
end