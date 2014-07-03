class AddVotesStatAnswersStatToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :votes_stat, :integer, default: 0
    add_column :questions, :answers_stat, :integer, default: 0
  end
end
