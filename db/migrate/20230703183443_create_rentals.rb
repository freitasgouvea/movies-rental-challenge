class CreateRentals < ActiveRecord::Migration[7.0]
  def change
    create_table :rentals, primary_key: :id do |t|
      t.references :movie, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.boolean :active, null: false

      t.timestamps
    end

    add_index :rentals, [:user_id, :movie_id], unique: true
  end
end
