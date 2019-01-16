class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.datetime :start_worktime
      t.datetime :end_worktime
      t.integer :worker_number
      t.string :card_id
      t.timestamps
    end
  end
end
