class Create movies < ActiveRecord::Migration
  def up
      create_table :movies do |t|
      t.string :name
      t.string :description
      t.integer :people_id
    end
  end

  def down
    drop_table :movies
  end
end
