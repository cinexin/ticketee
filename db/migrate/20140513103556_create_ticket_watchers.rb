class CreateTicketWatchers < ActiveRecord::Migration
  def change
  	# we don't want an id for this table...
    create_table :ticket_watchers, id: false do |t|
      t.integer :user_id
      t.integer :ticket_id
      # we also don't want timestamps for this model...
      # t.timestamps
    end
  end
end
