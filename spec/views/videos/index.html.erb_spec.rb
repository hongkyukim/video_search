require 'spec_helper'

describe "videos/index" do
  before(:each) do
    assign(:videos, [
      stub_model(Video,
        :title => "Title",
        :description => "Description",
        :provider => "Provider",
        :yt_video_id => "Yt Video",
        :url => "Url",
        :is_complete => false,
        :continue => "Continue"
      ),
      stub_model(Video,
        :title => "Title",
        :description => "Description",
        :provider => "Provider",
        :yt_video_id => "Yt Video",
        :url => "Url",
        :is_complete => false,
        :continue => "Continue"
      )
    ])
  end

  it "renders a list of videos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Provider".to_s, :count => 2
    assert_select "tr>td", :text => "Yt Video".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Continue".to_s, :count => 2
  end
end
