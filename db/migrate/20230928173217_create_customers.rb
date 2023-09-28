class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.string :telephone
      t.string :avatar
      t.string :smoke

      t.timestamps
    end
  end
end
