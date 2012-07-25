require 'spec_helper'

describe "videos/edit" do
  before(:each) do
    @video = assign(:video, stub_model(Video,
      :title => "MyString",
      :description => "MyString",
      :provider => "MyString",
      :yt_video_id => "MyString",
      :url => "MyString",
      :is_complete => false,
      :continue => "MyString"
    ))
  end

  it "renders the edit video form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => videos_path(@video), :method => "post" do
      assert_select "input#video_title", :name => "video[title]"
      assert_select "input#video_description", :name => "video[description]"
      assert_select "input#video_provider", :name => "video[provider]"
      assert_select "input#video_yt_video_id", :name => "video[yt_video_id]"
      assert_select "input#video_url", :name => "video[url]"
      assert_select "input#video_is_complete", :name => "video[is_complete]"
      assert_select "input#video_continue", :name => "video[continue]"
    end
  end
end
