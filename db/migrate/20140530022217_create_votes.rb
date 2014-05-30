class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :voice
      t.references :user, index: true
      t.references :votable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
