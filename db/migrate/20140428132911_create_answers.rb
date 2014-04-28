class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :body
      t.integer :votes, default: 0
      t.references :question, index: true

      t.timestamps
    end
  end
end
