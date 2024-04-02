class AddAdditionalColumnsToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :duration, :integer
    add_column :movies, :vote_average, :float
    add_column :movies, :vote_count, :integer
  end
end
