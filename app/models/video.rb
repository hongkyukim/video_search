
require 'camideo'

class Video < ActiveRecord::Base
  has_and_belongs_to_many :channels

  validates :title, :presence => true, :length => { :maximum => 256 }

  ##acts_as_commentable
  
  ##attr_accessor :comment
  attr_accessor :youtubevideo

  scope :completes,   where(:is_complete => true)
  scope :incompletes, where(:is_complete => false)

  def create_comment(comment)
    begin
      comments.create(:comment => comment)
      ###Video.yt_session.add_comment(yt_video_id, comment)
    rescue
      false
    end
  end
  
    
  def self.yt_session
    @yt_session ||= YouTubeIt::Client.new(:username => YouTubeITConfig.username ,
             :password => YouTubeITConfig.password , :dev_key => YouTubeITConfig.dev_key)    
  end

  def self.delete_video(video)
    ####yt_session.video_delete(video.yt_video_id)
    video.destroy
      rescue
        video.destroy
  end

  def self.update_video(video, params)
    ####yt_session.video_update(video.yt_video_id, video_options(params))
    video.update_attributes(params)
  end

  def self.token_form(params, nexturl)
    ###yt_session.upload_token(video_options(params), nexturl)
  end

  def self.delete_incomplete_videos
    self.incompletes.map{|r| r.destroy}
  end

  def self.get_VideoSearch123
     ###@ytVideo = YouTubeVideo.new
    return YouTubeVideo.get_VideoSearch     ### youtube

  end

  def self.get_VideoSearch

    @feeds = Feed.all
    ###request = YouTubeIt::Request::VideoSearch.new(:query => "penguin", :duration => "short")
    ##request = YouTubeIt::Request::VideoSearch.new(:query => "penguin", :duration => "short")
    
    ##response = yt_session.videos_by(:query => "korea news kbs mbc")        #####(request.url)
    ####Debug(response)
	####video = response.videos.first

    @feeds.each { |f|
        ###response = yt_session.videos_by(:query => f.queries, :max_results => 3, :time => :today) ###f.queries)

        get_OneVideoSearch(f) 

 

    }

    ###return     ###YouTubeIt::Parser::VideosFeedParser.new(response).parse
  end
  

    #@videos = Video.all
    ###request = YouTubeIt::Request::VideoSearch.new(:query => "penguin", :duration => "short")
    #request = YouTubeIt::Request::VideoSearch.new(:query => "penguin", :duration => "short")
    
    #response = yt_session.videos_by(:query => "korea news kbs mbc")        #####(request.url)
    ####Debug(response)
    ####video = response.videos.first

   ###return response.videos    ###YouTubeIt::Parser::VideosFeedParser.new(response).parse
  def self.get_OneVideoSearch(f)

    channel_id = f.channel_id
    if f.feedtype == 'selected'
        ### for selected channels
        ### f.feedtype: 'selected',  f.options: 'top_rated'
        ### top_rated, top_favorites, most_viewed, most_popular, most_recent, most_discussed, most_linked, most_responded,
        ### recently_featured, watch_on_mobile
        ###res = yt_session.videos_by(f.options)  ### ":top_rated, :time => :today" selected
        ### :time => :today, :max_results => 30, :page => 2  
	case f.options
	when 'most_viewed'
            res = yt_session.videos_by(:most_viewed, :max_results => 10, :page => 1 )
	when 'most_popular'
            res = yt_session.videos_by(:most_popular, :max_results => 10, :page => 1)
	when 'top_rated'
            res = yt_session.videos_by(:top_rated, :max_results => 10, :page => 1)
	when 'recently_featured'
            res = yt_session.videos_by(:recently_featured, :max_results => 10, :page => 1)
	when 'top_favorites'
            res = yt_session.videos_by(:top_favorites, :max_results => 10, :page => 1)
	else
	    logger.alert "Alert: This option #{f.options} is not supported."
	end

    else
        res = yt_session.videos_by(video_yt_options(f)) ###f.queries)
    end

    ### search thru youtube
    res.videos.each { |v| add_video(v, channel_id) }

    ### search camideo: vimeo, dailymotion, ...
    Camideo.get_OneVideoSearch_camideo(f)


  end

  def self.add_video(v, channel_id)

    return if v.title.empty?
    return if v.description.nil?
    return if v.player_url.empty?
    return if v.video_id.empty?

    ##logger.info 'video: ' + v.title
    ##logger.info '    d: ' + v.description
    ##logger.info 'thumbnail url: ' + v.thumbnails[0].url

    prov = 'youtube' 

    split_video_id = v.video_id.split(/:/);
    return if split_video_id[3].empty?

    ###debugger
    mvideo = Video.find_by_sql("SELECT * FROM videos v WHERE v.provider = '#{prov}' and v.yt_video_id = '#{split_video_id[3]}'")

    
    if mvideo.empty?
       ###debugger
       logger.info 'new video inserted:  split_video_id[3] = ' + split_video_id[3]
       logger.info 'new video inserted: provider =  ' + prov
       ##
       ##thumbnail_url has   v.thumbnails[0].url for thumbnails jpg
       
       ## convert time(seconds) to H:M:S format
       durationHMS = Time.at(v.duration).utc.strftime("%H:%M:%S")

       ## categories and keywords are text type (string type - max size 256)
       linkurl = 'http://www.youtube.com/watch?v=' + split_video_id[3] + '&feature=youtube_gdata'
       if v.media_content[0]
          embedlink = v.media_content[0].url ? v.media_content[0].url : null
       end
       if v.categories[0]
          categories = v.categories[0].term + " " +  v.categories[0].label
       end
       ## duration = v.duration

###debugger
       @newvideo = Video.create(:title => v.title, :description => v.description,
                     :yt_video_id => split_video_id[3],  :provider => prov,
                     :thumbnail_url => v.thumbnails[0].url, :duration => durationHMS, 
                     :linkurl => linkurl, 
                     #####:views => v['views'],  
                     :embedcode => embedlink,
                     :categories => categories, :keywords => v.keywords)

       @channel = Channel.find_by_id(channel_id)
       @newvideo.save
       Channel.video_add(@channel, @newvideo)
    else
       @channel = Channel.find_by_id(channel_id)
       mvideo.each { |m| Channel.video_add(@channel, m) }
    end 
  end

  private

    def self.video_options(params)
      opts = {:title => params[:title],
             :description => params[:description],
             :category => "People",
             :keywords => ["test"]}
      params[:is_unpublished] == "1" ? opts.merge(:private => "true") : opts
    end

    def self.video_yt_options(f)
      opts = {:query => f.queries}
      str = f.options
      if str.nil? || str == ""
debugger
         opts
      end
      ###debugger
      str.split(',').each do |x| 
         v,k = x.split(/\s*=>\s*/)
         ###opts[v] ||= []
         opts[v] = k
      end
      ###debugger

      opts
      ###f.options == "" ? opts : opts.merge(eval(f.options))
    end
end
