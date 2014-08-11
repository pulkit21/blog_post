class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.references :user, null: false, index: true
      t.datetime :published_at
      t.timestamps
    end
  end
end
