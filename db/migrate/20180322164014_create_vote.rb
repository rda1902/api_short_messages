class CreateVote < ActiveRecord::Migration[5.1]

  def change
    create_table :votes do |t|
      t.references :user, null: false
      t.references :message, null: false
      t.timestamps null: false
    end
  end

end
