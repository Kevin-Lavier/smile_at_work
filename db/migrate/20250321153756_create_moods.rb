class CreateMoods < ActiveRecord::Migration[8.0]
  def change
    create_table :moods do |t|
      t.string :emoji
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
