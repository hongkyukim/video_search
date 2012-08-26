class Feed < ActiveRecord::Base
  belongs_to :channel
  ### can be duplicated for different channels
  ## :uniqueness => false
  validates :name, :presence => true, :length => { :maximum => 256 }

  ## create first query feed of channel
  def self.make_firstfeed(channel)
     feedoptions = {"name"=>channel.name, "feedtype"=>"public", "queries"=>channel.name, "options"=>"", "keywords"=>"", "channel_id"=>channel.id}
     if channel.feeds.count == 0
         @feed = channel.feeds.build(feedoptions)
         if @feed.save
            Video.get_OneVideoSearch(@feed)
         end
     else
         channel.feeds.each { |f| Video.get_OneVideoSearch(f) }
     end
  end


end
