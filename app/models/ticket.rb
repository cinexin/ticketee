class Ticket < ActiveRecord::Base
	# relationships
  	belongs_to :project
  	belongs_to :user

  	# validations
  	validates :title, presence: true
  	validates :description, presence: true, length: {minimum:10}
  	# you can do it in one line if you prefer...
  	# validates: :title, :description, presence: true

  	# we need the "CarrierWave" gem to allow this line to work
  	# we'll also need an uploader (see "app/uploaders/asset_uploader.rb" file)
  	mount_uploader :asset, AssetUploader
end
