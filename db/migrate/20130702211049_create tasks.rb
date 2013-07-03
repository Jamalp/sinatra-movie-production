class Create tasks < ActiveRecord::Migration
  def up
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.boolean :complete
      t.integer :movie_id
      t.integer :people_id
    end
  end

  def down
    drop_table :tasks
  end
end
