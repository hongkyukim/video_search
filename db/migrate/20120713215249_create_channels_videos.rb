class CreateChannelsVideos < ActiveRecord::Migration
  def self.up
    # Create the association table
    create_table :channels_videos, :id => false do |t|
      t.integer :channel_id, :null => false
      t.integer :video_id, :null => false
    end

    # Add table index
    add_index :channels_videos, [:channel_id, :video_id], :unique => true

  end

  def self.down
    remove_index :channels_videos, :column => [:channel_id, :video_id]
    drop_table :channels_videos
  end
end
