require 'open-uri'
require 'json'

class Camideo


                        ##<option value="youtube">YouTube</option>
                        ##<option value="vimeo">Vimeo</option>
                        ##<option value="myspace">MySpace</option>
                        ##<option value="metacafe">MetaCafe</option>
                        ##<option value="dailymotion">DailyMotion</option>
                        ##<option value="soundcloud">SoundCloud</option>


  Camideo_API_KEY = '0a6e4aa28d539dd51821182be34028e1'
  Provider_list = 'youtube'
  Provider = 'youtube'


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

  def self.get_OneVideoSearch(f)

    channel_id = f.channel_id
    ###res = yt_session.videos_by(video_ytoptions(f)) ###f.queries)

    queries = self.query_options(f)

    url = "http://www.camideo.com/api/?key=" + Camideo_API_KEY + "&source=" + Provider + "&q=" + queries + "&response=json&page=1"

     #####response = Net::HTTP.get_response("example.com","/?search=thing&format=json")
     ###response = Net::HTTP.get_response(url, parameters)

     ####response = json_decode(jresponse, TRUE);

     buffer = open(url, "UserAgent" => "Ruby-Wget").read
     response = JSON.parse(buffer)


    if ( response &&  response['Camideo']['Error'] )
         ### error
         return
    end

    response['Camideo']['videos'].each { |v| add_video(v, channel_id) }

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

  def self.add_video(v, channel_id)

    return if v['title'].empty?
    return if v['description'].nil?
    return if v['link'].empty?
    return if v['videoId'].empty?

    ##logger.info 'video: ' + v.title
    ##logger.info '    d: ' + v.description
    ###logger.info 'thumbnail url: ' + v.thumbnails[0].url

    prov = Provider 

    split_video_id = v['videoId']

    ###debugger
    mvideo = Video.find_by_sql("SELECT * FROM videos v WHERE v.provider = '#{prov}' and v.yt_video_id = '#{split_video_id}'")

   
    if mvideo.empty?
       ###debugger
       ##
       ##thumbnail_url has   v.thumbnails[0].url for thumbnails jpg
       ## categories and keywords are text type (string type - max size 256)

       ##categories = v.categories[0].term + " " +  v.categories[0].label

       @newvideo = Video.create(:title => v['title'], :description => v['description'],
                      :yt_video_id => split_video_id,  :provider => prov, 
                      ####:thumbnail_url => "",
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
