class CreateMessage < ActiveRecord::Migration[5.1]

  def change
    create_table :messages do |t|
      t.string :text, null: false
      t.references :user, null: false
      t.timestamps null: false
    end
  end

end
