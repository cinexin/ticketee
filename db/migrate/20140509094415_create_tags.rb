class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
    end

    # relationship table
    # we pass the ":id=>false" option to avoid the generation of the "id" field to the table
    create_table :tags_tickets, :id=>false do |t|
    	t.integer :tag_id, :ticket_id
    end

  end
end
