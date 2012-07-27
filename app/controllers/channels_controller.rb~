class ChannelsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:show, :index, :videos]
  load_and_authorize_resource

  def index
    @channels = Channel.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @channels }
    end
  end

  def show
   @channel = Channel.find(params[:id])
   @feeds = @channel.feeds

    respond_to do |format|
      ##debugger
      format.html # show.html.erb
      format.json { render json: @channel }
    end
  end

  def new
    @channel = Channel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @channel }
    end
  end

  def edit
    @channel = Channel.find(params[:id])
  end

  def create
    @channel = Channel.new(params[:channel])

    
    respond_to do |format|
      if @channel.save
        ## create the first query feed of this channel automatically
        Feed.make_firstfeed(@channel)

        format.html { redirect_to @channel, notice: 'Channel was successfully created.' }
        format.json { render json: @channel, status: :created, location: @channel }
        format.mobile { redirect_to @channel, notice: 'Channel was successfully created.' }
      else
        format.html { render action: "new" }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
        format.mobile { render action: "new" }
      end
    end
  end

  def update
    @channel = Channel.find(params[:id])

    respond_to do |format|
      if @channel.update_attributes(params[:channel])
        format.html { redirect_to @channel, notice: 'Video was successfully updated.' }
        format.json { head :no_content }
        format.mobile { redirect_to @channel, notice: 'Video was successfully updated.' }
      else
        format.html { render action: "edit" }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @channel = Channel.find(params[:id])
    @channel.destroy

    respond_to do |format|
      format.html { redirect_to channels_url }
      format.json { head :no_content }
    end
  end


  # Display all videos of a channel
  def videos
   @channel = Channel.find(params[:id])
   @videos = Channel.find(params[:id]).videos.reverse
   
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @videos }
    end
  end



end
