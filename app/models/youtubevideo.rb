class YouTubeVideo < ActiveRecord::Base

  ##acts_as_commentable
  
  ##attr_accessor :comment
  
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
    @yt_session ||= YouTubeIt::Client.new(:username => YouTubeITConfig.username , :password => YouTubeITConfig.password , :dev_key => YouTubeITConfig.dev_key)    
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


  def self.get_VideoSearch
    ###request = YouTubeIt::Request::VideoSearch.new(:query => "penguin", :duration => "short")
    request = YouTubeIt::Request::VideoSearch.new(:query => "penguin", :duration => "short")
    
    response = yt_session.videos_by(:query => "korea news kbs mbc")        #####(request.url)
    ####Debug(response)
	####video = response.videos.first
    response.videos.each { |v| add_video(v) }

    return response.videos    ###YouTubeIt::Parser::VideosFeedParser.new(response).parse
  end

  def self.add_video(v)

    return if v.title.empty?
    return if v.description.nil?
    return if v.player_url.empty?
    return if v.video_id.empty?

    logger.info 'video: ' + v.title
    logger.info '    d: ' + v.description
    logger.info 'player url: ' + v.player_url

 

    split_video_id = v.video_id.split(/:/);
    return if split_video_id[3].empty?
    #####debugger

    @mvideo = Video.create(:title => v.title, :description => v.description, :yt_video_id => split_video_id[3], :url => v.player_url);
    @mvideo.save
    return v  
  end

  private
    def self.video_options(params)
      opts = {:title => params[:title],
             :description => params[:description],
             :category => "People",
             :keywords => ["test"]}
      params[:is_unpublished] == "1" ? opts.merge(:private => "true") : opts
    end
end
