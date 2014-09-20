class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.references :user, null: false, index: true
      t.references :post, null: false, index: true
      t.timestamps
    end
  end
end
