class ReplaceColumnfieldsInTweets < ActiveRecord::Migration[6.1]
  def change
    remove_column :tweets, :published_at
    add_column :tweets, :publish_at, :datetime
  end
end
