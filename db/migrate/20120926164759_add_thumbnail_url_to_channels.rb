class AddThumbnailUrlToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :thumbnail_url, :string

  end
end
