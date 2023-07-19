class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, primary_key: :id do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
