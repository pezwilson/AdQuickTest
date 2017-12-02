class CreateBillboards < ActiveRecord::Migration[5.1]
  def change
    create_table :billboards do |t|
      t.string :name,              null: false
      t.string :image,              null: false
      t.integer :upvotes,        default: 0
      t.integer :downvotes,        default: 0
      t.integer :score,        default: 0

      t.timestamps null: false
    end
  end
end
