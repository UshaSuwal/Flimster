class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :mid
      t.string :original_title
      t.text :overview
      t.string :poster
      t.float :popularity

      t.timestamps
    end
  end
end
