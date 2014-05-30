class Ticket < ActiveRecord::Base



	 # relationships
  	belongs_to :project
  	belongs_to :user
    has_many :assets
    accepts_nested_attributes_for :assets
    has_many :comments
    belongs_to :state
    # This association will rely on a join table called "tags_ticket"
    # NOTE: the table by default will be the combination, in alphabetical order, of the two tables you want to join
    #       the fields will be, as expected, ticket_id and tag_id
    has_and_belongs_to_many :tags

    # similarly as above, we have a "many to many" relation in the "ticket_watchers" table
    has_and_belongs_to_many :watchers, join_table: "ticket_watchers",
                                     class_name: "User"


  	# validations
  	validates :title, presence: true
  	validates :description, presence: true, length: {minimum:10}
  	# you can do it in one line if you prefer...
  	# validates: :title, :description, presence: true

  	# we need the "CarrierWave" gem to allow this line to work
  	# we'll also need an uploader (see "app/uploaders/asset_uploader.rb" file)
  	#mount_uploader :asset, AssetUploader


    # this is a "virtual attribute", that is, a field that it's not mapped / persisted directly in the database
    # this is the way we define in Ruby virtual attributes in classes
    # this method will define a getter and setter method for the specified attribute
    attr_accessor :tag_names

    before_create :associate_tags
    after_update :sanitize_assets

    # we register the creator as a watcher of the ticket
    after_create :creator_watches_me

    def self.search(query)
      terms = {}
      query.split(" ")
        .map do |query|
          k, v = query.split(":")
          terms[k] = v
        end

      relation = all

      if terms.has_key?("tag")
        relation = joins(:tags).where("tags.name = ?", terms['tag'])
      end

      if terms.has_key?("state")
        relation = joins(:state).where("states.name = ?", terms['state'])
      end

      relation
    end



    private

    def associate_tags
      if tag_names
        tag_names.split(" ").each do |name|
          # the "find_or_create_by" is a dynamic finder of "ActiveRecord" objects
          self.tags << Tag.find_or_create_by(name:name)
        end
      end
    end


    def creator_watches_me
      if user
        self.watchers << user unless self.watchers.include?(user)
      end
    end


    # it seems every time we update the ticket, an empty asset is added to the collection :-(
    def sanitize_assets
      assets.each do |asset|
        if !asset.asset.url
          assets.delete(asset)
        end
      end
    end
end
