class CreateQuestionsTags < ActiveRecord::Migration
  def change
    create_table :questions_tags, id: false do |t|
      t.belongs_to :question
      t.belongs_to :tag
    end
  end
end
