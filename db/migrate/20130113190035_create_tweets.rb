class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :text
      t.string :id_str
      t.string :media_url
      t.text :raw
      t.references :user

      t.timestamps
    end
    add_index :tweets, :user_id
  end
end
