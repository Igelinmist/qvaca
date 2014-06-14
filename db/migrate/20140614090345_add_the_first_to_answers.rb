class AddTheFirstToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :the_first, :integer, default: 0
    add_index :answers, :the_first
  end
end
