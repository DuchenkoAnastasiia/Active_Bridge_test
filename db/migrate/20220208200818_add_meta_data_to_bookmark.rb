class AddMetaDataToBookmark < ActiveRecord::Migration[6.1]
  def change
    add_column :bookmarks, :meta_data, :jsonb
  end
end
