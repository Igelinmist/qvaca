class AddRatingToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :rating, :integer, default: 0
  end
end
