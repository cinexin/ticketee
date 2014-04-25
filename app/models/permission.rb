class Permission < ActiveRecord::Base
	
	belongs_to :user
	# this "polymorphic" thing means that  it can be related to 
	# many kind of objects
	# Rails knows the object what is related by using
	# "thing_type" and  "thing_id" fields (view "generating_with_rails.sh")
	# when you save a polymorphic association, Rails also saves 
	# the typical "thing_id" field and a "thing_type" field
	# the "thing_type" field is the result of calling to "thing.class.to_s"
	# Similarly, loading a polymorphic field uses the "thing_id"
	# and "thing_type" fields to find the related object
	belongs_to :thing, polymorphic: true
end
