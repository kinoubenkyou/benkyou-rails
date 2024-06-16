class CreateOrganizations < ActiveRecord::Migration[7.1]
  def change
    create_table :organizations do |t|
      t.string :code, index: { unique: true }, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
