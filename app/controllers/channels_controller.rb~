require 'http_accept_language'

class ChannelsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:show, :index, :videos]
  load_and_authorize_resource
  helper_method :sort_column, :sort_direction

  def index
    ## provide all channels
    ##@user = User.find(params[:user_id])
    ##@channels = @user.channels
    ### get all channels

    ###@channels = Channel.all

    ###channels = Channel.find(:all)
    ### update thumbnail_url for channels
    ###channels.each { |c|   c.update_attributes({ "thumbnail_url" => c.videos[0].thumbnail_url}) if c.thumbnail_url.blank? }

    ###channels = Channel.find(:all)
    ### update thumbnail_url for channels
    ###channels.each { |c|    raise false if c.thumbnail_url.blank? }


    ###@channels = Channel.search(params[:search]).reverse
    ###@products = Product.order(sort_column + ' ' + sort_direction).paginate(:per_page => 5, :page => params[:page])
    ##@channels = Channel.search(params[:search]).reverse
    ###@channels = Channel.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(:per_page => 3, :page => params[:page]).reverse
    if cookies[:user_languages]
       userlanguages = cookies[:user_languages] 
    else
       userlanguages = "en"
    end
###debugger
    search_channels = Channel.search(params[:search], params[:categories_search], userlanguages)

    search_channels_all = Channel.search(params[:search], params[:categories_search])
##debugger
    if search_channels == 1 || search_channels.nil? || search_channels.count == 0
         @channels = nil
    else
         if mobile_device?
              @channels = search_channels.order(sort_column + ' ' + sort_direction).reverse
         else
              @channels = search_channels.order(sort_column + ' ' + sort_direction).paginate(:per_page => 10,
                           :page => params[:page]).reverse
         end
    end


    @languages = Language.find(:all)

    if params[:loggedin] == 'yes' && current_user
        respond_to do |format|
           format.js
           format.html { redirect_to user_channels_path(current_user) }
           format.json { render json: user_channels_path(current_user) }
           format.mobile { redirect_to user_channels_path(current_user) }

        end
    else

	respond_to do |format|
           format.js
	   format.html # index.html.erb
	   format.json { render json: @channels }

	end
    end
  end

  def myindex
    ## provide all channels
    @user = User.find(params[:user_id])
    @channels = @user.channels

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @channels }
    end
  end

  def show
    ###@user = User.find(params[:user_id])
    ##@user = User.find(params[:user_id])
    @channel = Channel.find(params[:id])
    @user = User.find(@channel.user_id)

    respond_to do |format|
      ##debugger
      format.html # show.html.erb
      format.json { render json: @channel }
    end
  end

  def new
    ##@channel = Channel.new
    ##@user = User.find(params[:user_id])
    @user = User.find(params[:user_id])
    @channel = @user.channels.build
    @user_language = get_user_language
    ### get current default language
    @cur_language_name, @cur_language_shortname = get_cur_language
    ### 
    ### param has string, advanced_new is integer
    if params[:advanced_new] == '1'
        @advanced_new = 1 
    else
        @advanced_new = 0
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @channel }
    end
  end

  def edit
    ##@channel = Channel.find(params[:id])
    ##@user = User.find(params[:user_id])
    @channel = Channel.find(params[:id])
    @user = User.find(@channel.user_id)

    @cur_language_name, @cur_language_shortname = get_cur_language
  end

  def create
    ###@channel = Channel.new(params[:channel])
    @user = User.find(params[:user_id])
    ### take lower case
    params[:channel][:name] = params[:channel][:name].downcase

    ### set channel_type, tags, and categories
    ### channel_type's default is public
    params[:channel][:channel_type] = "public" if params[:channel][:channel_type].nil?

    ### set languages
    ##params[:channel][:language] = Channel.find_preferred_language
    ###renv = request.env["HTTP_ACCEPT_LANGUAGE"]

    languages = request.user_preferred_languages

    ###rhost = request.host

    ###iavailable = I18n.available_locales

    ###available = %w{en en-US nl-BE kr}
    ###http_accept_language = env['http_accept_language']

    ###preferred = request.preferred_language_from(available) # => 'nl-BE'

    params[:channel][:language] = languages if params[:channel][:language].nil?

    ### set language and user_id
    cur_language_name, cur_language_shortname = get_cur_language

    params[:channel][:language] = cur_language_shortname
    params[:channel][:user_id] = @user.id if params[:channel][:user_id].nil?
    @channel = @user.channels.build(params[:channel])
    
##debugger
    
      if @channel.save
        ## create the first query feed of this channel automatically

        Feed.make_firstfeed(@channel)

        ### update thumbnail_url for channel with the first video's thumbnail_url
        video = @channel.videos[0]

        ###@channel.querytime = Time.now;
        if video 
          @channel.update_attributes({ "querytime" => DateTime.now, "thumbnail_url" => video.thumbnail_url})
          ###format.html { redirect_to @channel, notice: 'Channel was successfully created.' }
          ### create a channel and video list and then go to video list
##debugger
         respond_to do |format|
          format.html { redirect_to videos_channel_path(@channel), notice: 'Channel was successfully created.' }
          format.json { redirect_to user_channels_path(@user), notice: 'Channel was successfully created with Json.' }
          ###format.html { redirect_to videos_channel_path(@channel), notice: 'Channel was successfully created.' }
          ####format.json { render json: @channel, status: :created, location: @channel }
          ###format.mobile { redirect_to user_channels_path(@user), notice: 'Channel was successfully created.' }
          format.mobile { redirect_to videos_channel_path(@channel), notice: 'Channel was successfully created.' }
         end

        else
           ### no videos
           @channel.destroy

          respond_to do |format|
           format.html { redirect_to new_user_channel_path(@user), :advanced_new => '0', notice: 'Channel was not successfully created. There are no videos.' }
           format.json { render json: @channel.errors, status: :unprocessable_entity }
           format.mobile { render action: "new", notice: 'Channel was not successfully created. There are no videos.' }
          end

        end


      else
       respond_to do |format|
        format.html { render action: "new" }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
        format.mobile { render action: "new" }
       end
      end
    
  end

  def update
    ##@channel = Channel.find(params[:id])
    @user = User.find(params[:user_id])
    @channel = @user.channels.find(params[:id])

    respond_to do |format|
      if @channel.update_attributes(params[:channel])
        format.html { redirect_to @channel, notice: 'Channel was successfully updated.' }
        format.json { head :no_content }
        format.mobile { redirect_to @channel, notice: 'Channel was successfully updated.' }
      else
        format.html { render action: "edit" }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
        format.mobile { redirect_to @channel, notice: 'Channel was not successfully updated.' }
     end
    end
  end

  def destroy
    ##@channel = Channel.find(params[:id])
    ##@channel.destroy
    ##@user = User.find(params[:user_id])
    ##@channel = Channel.find(params[:id])
    
    @channel = Channel.find(params[:id])
    @user = User.find(@channel.user_id)
 
    @channel.destroy

    respond_to do |format|
      format.html { redirect_to user_channels_path(@user) }
      format.json { head :no_content }
      format.mobile { redirect_to user_channels_path(@user) }
    end
  end


  # Display all videos of a channel
  def videos
    @channel = Channel.find(params[:id])

    #### search and add new videos if not within 1 hour(3600 seconds)
    newtime = DateTime.now
    oldtime = @channel.querytime.nil? ? DateTime.now - 2.days : @channel.querytime
    diff_time = (newtime.to_i-oldtime.to_i)/3600.00

    if diff_time > 0.999
        #### search and add new videos 
        Feed.make_firstfeed(@channel)
        @channel.update_attributes({ "querytime" => DateTime.now})
    end

    @videos = Channel.find(params[:id]).videos.reverse
   
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @videos }
    end
  end

private
  def sort_column
    Channel.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end 



 
end
