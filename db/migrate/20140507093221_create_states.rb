class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name
      t.string :color
      t.string :background

      # we need a reference in the tickets table
      add_column :tickets, :state_id, :integer
      # we add an index to speed up search queries
      add_index :tickets, :state_id

      # we need another reference in the comments table to track the states in wich the ticket passes
      add_column :comments, :state_id, :integer

    end
  end
end
