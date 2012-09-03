class AddQuerytimeToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :querytime, :datetime

  end
end
