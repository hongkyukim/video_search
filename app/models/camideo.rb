require 'open-uri'
require 'json'
####require 'logger'

class Camideo < ActiveRecord::Base

  Camideo_API_KEY = '0a6e4aa28d539dd51821182be34028e1'
  Provider_list = 'youtube'
  Provider = 'youtube'
  ###3logger = Logger.new(STDOUT)
  MaxCount = 3;

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

  def self.get_VideoSearch123
        ###@ytVideo = YouTubeVideo.new
    return YouTubeVideo.get_VideoSearch     ### youtube

  end

  def self.get_VideoSearch

    @feeds = Feed.all
    @feeds.each { |f|
        get_OneVideoSearch(f) 
    }

    ###return     ###YouTubeIt::Parser::VideosFeedParser.new(response).parse
  end

  ### dailymotion  ->  keyword search does not work

  def self.get_OneVideoSearch_camideo(f)
       ### dm search is not good
       ###self.get_OneVideoSearch(f, 'dailymotion')
       ### vimeo is good
     self.get_OneVideoSearch(f, 'vimeo')
       ##self.get_OneVideoSearch(f, 'myspace')     ## error
       ##self.get_OneVideoSearch(f, 'metacafe')
       ##self.get_OneVideoSearch(f, 'soundcloud')
       ###self.get_OneVideoSearch(f, 'youtube')
  end

  def self.get_OneVideoSearch(f, provider)

    if f.feedtype == 'selected'
        ### for selected channels
        ### f.feedtype: 'selected',  f.options: 'top_rated'
        ### top_rated, top_favorites, most_viewed, most_popular, most_recent, most_discussed, most_linked, most_responded,
        ### recently_featured, watch_on_mobile
        ###res = yt_session.videos_by(f.options)  ### ":top_rated, :time => :today" selected
        ### :time => :today, :max_results => 30, :page => 2  
	###case f.options
	###when 'most_viewed'
        ###    res = yt_session.videos_by(:most_viewed, :max_results => 10, :page => 1 )
	###when 'most_popular'
        ###    res = yt_session.videos_by(:most_popular, :max_results => 10, :page => 1)
	###when 'top_rated'
        ###    res = yt_session.videos_by(:top_rated, :max_results => 10, :page => 1)
	###when 'recently_featured'
        ###    res = yt_session.videos_by(:recently_featured, :max_results => 10, :page => 1)
	###when 'top_favorites'
        ###    res = yt_session.videos_by(:top_favorites, :max_results => 10, :page => 1)
	###else
	###    logger.alert "Alert: This option #{f.options} is not supported."
	###end

        return   ### skip
    end

    channel_id = f.channel_id
    ###res = yt_session.videos_by(video_ytoptions(f)) ###f.queries)

    queries = self.query_options(f)

    url = "http://www.camideo.com/api/?key=" + Camideo_API_KEY + "&source=" + provider + "&q=" + queries + "&response=json&page=1"


    ### vimeo
    ### &per_page=1&summaty_response=1&full_response=1
    if provider == 'vimeo'
        url = url + "&sort=most_played&page=1&per_page=5&summary_response=1&full_response=1"
    end

    ### vimeo
    ### &per_page=1&summaty_response=1&full_response=1
    if provider == 'dailymotion'
        url = url + "&filters=featured&limit=5&page=1"
    end

     ###"http://www.camideo.com/api/?key=0a6e4aa28d539dd51821182be34028e1&source=youtube&q=chocolate&response=json&page=1"
     #####response = Net::HTTP.get_response("example.com","/?search=thing&format=json")
     ###response = Net::HTTP.get_response(url, parameters)

     ####response = json_decode(jresponse, TRUE);


     ### safeurl = URI.parse(URI.encode(url))

     ###buffer = open(url).read
    buffer = open(URI.encode(url), "UserAgent" => "Ruby-Wget").read
    if ( !buffer )
         ### error
         logger.info 'Alert camideo: provider ' + provider + ' buffer is empty'
        return
    end
    response = JSON.parse(buffer)
  
    if response.has_key? 'Error'
          raise "web service error in JSON.parse"
    end

    if ( response &&  response['Camideo']['Error'] )
         ### error
         logger.info 'Alert camideo: ' + provider + ' failed:'
         return
    end

    curCount = 0;
    response['Camideo']['videos'].each { |v| curCount = add_video(v, channel_id, provider, curCount) }

    ###return response.videos    ###YouTubeIt::Parser::VideosFeedParser.new(response).parse
  end

  ###    video info from Camideo
  ### 
  ###
  ###                      "videoId" : "45558546",
  ###                      "title" : "El Nakam!!",
  ###                      "link" : "http://vimeo.com/45558546",
  ###                      "description" : "my final project in shenkar school of arts.<br><br>animation & story: yonatan popper<br>original theme music: Assa Raviv & Itamar Fintzi<br><br>guided by Guy Harlap & Itamar Daube.<br><br>its a short animation trailer, for a movie that doesn't exists.<br>the animation is mostly classic: frame by frame animation<br><br>great thanks to: smadar & tal hunziker, max & eti popper, ido gildin, Idan Epshtien,<br>Elad Tayar, Daniel Goldfarb and nina limarev",
  ###                      "author" : "yonatan popper",                                               
  ###                      "authorLink" : "https://vimeo.com/user7744618",
  ###                      "duration" : "00:03:22",
  ###                      "embedCode" : "http://player.vimeo.com/video/45558546",
  ###                      "views" : "10895",
  ###                      "published" : "2012-07-11 02:22:08"

  def self.add_video(v, channel_id, prov, curCounter)

    return if v['title'].empty?
    return if v['description'].nil?
    return if v['link'].empty?
    return if v['videoId'].empty?

    ##logger.info 'video: ' + v.title
    ##logger.info '    d: ' + v.description
    ###logger.info 'thumbnail url: ' + v.thumbnails[0].url

    ###prov = Provider 

    split_video_id = v['videoId']

    ###debugger
    mvideo = Video.find_by_sql("SELECT * FROM videos v WHERE v.provider = '#{prov}' and v.yt_video_id = '#{split_video_id}'")

   
    if mvideo.empty?
       ###debugger
       ##
       ##thumbnail_url has   v.thumbnails[0].url for thumbnails jpg
       ## categories and keywords are text type (string type - max size 256)

       ##categories = v.categories[0].term + " " +  v.categories[0].label

       if MaxCount < curCounter

          return curCounter
       end
       curCounter += 1

       thumbnail_url = ""
       if prov == 'dailymotion'
          thumbnail_url = 'dailymotion120_90.jpg'
       elsif prov == 'vimeo'
          
          vimeo_video_json_url = "http://vimeo.com/api/v2/video/%s.json" % split_video_id
          # Parse the JSON and extract the thumbnail_large url
          thumbnail_url = JSON.parse(open(vimeo_video_json_url).read).first['thumbnail_medium'] rescue nil


          if thumbnail_url.nil? 
              thumbnail_url = 'dailymotion120_90.jpg'
          end
       end


       @newvideo = Video.create(:title => v['title'], :description => v['description'],
                      :yt_video_id => split_video_id,  :provider => prov, 
                      :thumbnail_url => thumbnail_url,
                      :duration => v['duration'],
                      :linkurl => v['link'], :views => v['views'],
                      :embedcode => v['embedCode']
                      ####, :categories => v['views'], :keywords => v['published']
                    )

       @channel = Channel.find_by_id(channel_id)
       @newvideo.save
       Channel.video_add(@channel, @newvideo)

    else

       @channel = Channel.find_by_id(channel_id)

       mvideo.each { |m| Channel.video_add(@channel, m) }
    end 
    curCounter
  end

  private

    def self.video_options(params)
      opts = {:title => params[:title],
             :description => params[:description],
             :category => "People",
             :keywords => ["test"]}
      params[:is_unpublished] == "1" ? opts.merge(:private => "true") : opts
    end

    def self.query_options(f)
      keywords = f.queries
      
      keylist = keywords.split(/\s\s*/)
      qstr = ""
      icnt = keylist.count
      keylist.each_with_index do |x, i| 
         qstr = qstr + x
         break if i == icnt - 1;
         qstr = qstr + '+'
      end
      qstr
    end
end
