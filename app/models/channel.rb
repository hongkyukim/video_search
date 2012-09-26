class Channel < ActiveRecord::Base
  has_many :feeds, :dependent => :destroy
  has_and_belongs_to_many :videos
  belongs_to :user

  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 256 }

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :channel_type, :tags, :categories, :language, :user_id, :querytime

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


  ### 
  ### search => nil   ---> all channels
  ### search => 'selected' ---> selected channels
  ### search => query ---> 
  def self.search(search)
      if search
          search = search.downcase
          if search == 'selected'
              ###find_by_channel_type(search) -- error not array
              find_by_sql("SELECT * FROM channels c WHERE c.channel_type = '#{search}' or c.id = 76")
          else
              find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
          end
      else
          find(:all)
      end
  end

 
end
