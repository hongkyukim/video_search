class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.string :provider
      t.string :yt_video_id
      t.string :url
      t.boolean :is_complete
      t.string :continue

      t.timestamps
    end
  end

end
