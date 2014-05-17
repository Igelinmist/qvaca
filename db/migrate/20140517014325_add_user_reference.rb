class AddUserReference < ActiveRecord::Migration
  def change
    add_reference :questions, :user, index: true
    add_reference :answers, :user, index: true
    add_reference :comments, :user, index: true
  end
end
