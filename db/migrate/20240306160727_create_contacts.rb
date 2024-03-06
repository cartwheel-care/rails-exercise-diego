class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.timestamps
    end

    add_reference :contacts, :patient, foreign_key: true
  end
end
