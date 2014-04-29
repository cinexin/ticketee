class Asset < ActiveRecord::Base
  	# we need the "CarrierWave" gem to allow this line to work
  	# we'll also need an uploader (see "app/uploaders/asset_uploader.rb" file)
	
	mount_uploader :asset, AssetUploader

  	belongs_to :ticket

  	# we need to update the "content type" of an asset
  	# before saving it...so we use...cross-cutting concerns?
  	# callbacks? name it whatever you want...
  	before_save :update_content_type

  	private
  	def update_content_type
  		if asset.present? && asset_changed?
  			self.content_type = asset.file.content_type
  		end
  	end
end
