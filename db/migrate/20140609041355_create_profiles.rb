class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :display_name
      t.string :real_name
      t.string :website
      t.string :location
      t.date :birthday
      t.text :about_me
      t.boolean :weekly_email
      t.string :avatar
      t.references :user, index: true

      t.timestamps
    end
  end
end
