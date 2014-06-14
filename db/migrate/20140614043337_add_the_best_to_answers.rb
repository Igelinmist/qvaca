class AddTheBestToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :best_graid, :integer, default: 0
    add_index :answers, :best_graid
  end
end
