class CreateBillboardVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :billboard_votes do |t|
      t.references(:billboard, index: true)
      t.references(:user, index: true)
      t.integer :direction,        default: 0

      t.timestamps null: false
    end
  end
end
