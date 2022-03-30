class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      # フォローするユーザのID
      t.integer :follower_id
      # フォローされるユーザのID
      t.integer :followed_id
      t.timestamps
    end
  end
end
