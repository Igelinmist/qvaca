class RemoveVotesFields < ActiveRecord::Migration
  def change
    remove_column :questions, :votes
    remove_column :answers, :votes
  end
end
