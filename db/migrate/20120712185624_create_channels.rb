class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :name
      t.string :channel_type
      t.string :tags
      t.string :categories
      t.string :language

      t.timestamps
    end
  end
end
