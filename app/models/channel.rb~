class Channel < ActiveRecord::Base
  has_many :feeds, :dependent => :destroy
  has_and_belongs_to_many :videos
 
  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 256 }

  def self.check_registered?(channel, video)
    channel.videos.include?(video)
  end

  # add video to this channel
  def self.video_add(channel, video)
    unless check_registered?(channel, video)
      channel.videos << video
    end
    ###redirect_to :action => :videos, :id => @channel
  end

  def video_remove

  end

 
end
