class ChangeDataTypeForDatetime < ActiveRecord::Migration[6.1]
  def change
    change_column :tweets, :published_at, :publish_at
  end
end
