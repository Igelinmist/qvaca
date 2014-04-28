class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.references :commentable, polymorphic: true, index: true
      t.integer :correction

      t.timestamps
    end
  end
end
