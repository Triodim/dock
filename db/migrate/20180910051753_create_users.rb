class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :email
      t.string :password_digest
      t.string :avatar
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
