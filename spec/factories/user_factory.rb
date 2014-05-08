FactoryGirl.define do
  
  # we've got a little issue: we can't set the same email
  # to all of our users, because sometimes we need to choose
  # a certain user by "clicking" their rendered email on the page
  # (see spec/features/admin/editing_users_spec.rb for example)
  # so we solve this using what they call "sequences"
  sequence(:email) { 
    |n|
    "user#{n}@example.com"
  } 
  
	# user
	factory :user do
		name "Example user"
		# this is the way we use the sequence created above
		email { generate(:email)}
		password "sample_password"
		password_confirmation "sample_password"

		  # admin user
		factory :admin_user do
			name "Admin user"
			admin true
		end
	end
end