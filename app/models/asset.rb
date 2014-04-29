class Asset < ActiveRecord::Base
  	# we need the "CarrierWave" gem to allow this line to work
  	# we'll also need an uploader (see "app/uploaders/asset_uploader.rb" file)
	
	mount_uploader :asset, AssetUploader

  	belongs_to :ticket
end
