class AddSelfAnswerToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :self_answer, :integer, default: 0
    add_index :answers, :self_answer
  end
end
