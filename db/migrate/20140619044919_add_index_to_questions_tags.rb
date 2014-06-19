class AddIndexToQuestionsTags < ActiveRecord::Migration
  def change
    add_index :questions_tags, :question_id
    add_index :questions_tags, :tag_id
  end
end
