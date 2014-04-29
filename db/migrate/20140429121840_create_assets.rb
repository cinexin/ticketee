class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
    	t.string :asset
    	t.references :ticket
      	t.timestamps
    end
    # we don't need the "asset" column in the "ticket" model anymore...
    remove_column :tickets, :asset
  end
end
