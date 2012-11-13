class FeedsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:show, :index]
  load_and_authorize_resource

  def index
    @channel = Channel.find(params[:channel_id])
    @feeds = @channel.feeds
  end

  def show
    @channel = Channel.find(params[:channel_id])
    @feed = @channel.feeds.find(params[:id])

    respond_to do |format|
      ##debugger
      format.html # show.html.erb
      format.json { render json: @feed }
    end

  end

  def new
    @channel = Channel.find(params[:channel_id])
    @feed = @channel.feeds.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @feed }
    end
  end

  def edit
    @channel = Channel.find(params[:channel_id])
    @feed = @channel.feeds.find(params[:id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @feed }
    end
  end

  def create
    ## params -> {"utf8"=>"✓", "authenticity_token"=>"XSkDyJCjujGdChiq3U8LLisPtQ98JUDzSQIFHaouMQA=",
    ##  "feed"=>{"name"=>"new345feed", "feedtype"=>"public", "queries"=>"new345keyword ",
    ## "options"=>"", "keywords"=>"", "channel_id"=>"42"}, "action"=>"create", "controller"=>"feeds",
    ## "channel_id"=>"42", "format"=>"mobile"}

    ## params[:channel_id] -> 42
    @channel = Channel.find(params[:channel_id])
    ## params[:feed] => {"name"=>"new345feed", "feedtype"=>"public", "queries"=>"new345keyword ",
    ##                              "options"=>"", "keywords"=>"", "channel_id"=>"42"}

    params[:feed][:name] = params[:feed][:name].downcase
    params[:feed][:channel_id] = @channel.id if params[:feed][:channel_id].nil?
    ### if queries is empty, copy name to queries
    params[:feed][:queries] = params[:feed][:name] if params[:feed][:queries].nil?

    @feed = @channel.feeds.build(params[:feed])
    ### check duplication
    dup_feeds = @channel.feeds.find_by_name(@feed.name)
debugger
    respond_to do |format|
      if dup_feeds 

        format.html { render action: "new" }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
        format.mobile { redirect_to channel_path(@channel), notice: 'This Query Name was already defined.' }

      elsif @feed.save
        ## search videos using query with keywords
        Video.get_OneVideoSearch(@feed)
        format.html { redirect_to channel_path(@channel), notice: 'Query was successfully created.' }
        format.json { render json: channel_feed_path(@channel), status: :created, location: @feed }
        format.mobile { redirect_to channel_path(@channel), notice: 'Query was successfully created.' }
      elsif
        format.html { render action: "new" }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
        format.mobile { redirect_to channel_path(@channel), notice: 'This Query was not created.' }
      end
    end
  end

  def update
    @channel = Channel.find(params[:channel_id])
    @feed = @channel.feeds.find(params[:id])

    respond_to do |format|
      if @feed.update_attributes(params[:feed])
        format.html { redirect_to channel_feed_path(@channel), notice: 'Query was successfully updated.' }
        format.json { head :no_content }
        format.mobile { redirect_to channel_feed_path(@channel), notice: 'Query was successfully updated.' }
      else
        format.html { render action: "edit" }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
        format.mobile { redirect_to channel_feed_path(@channel), notice: 'Query was not successfully updated.' }
      end
    end
  end
  def destroy

    @channel = Channel.find(params[:channel_id])
    @feed = Feed.find(params[:id])

    @feed.destroy

    respond_to do |format|
      format.html { redirect_to channel_path(@channel) }
      format.xml  { head :ok }
    end
  end

end
