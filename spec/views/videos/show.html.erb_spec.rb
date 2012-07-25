require 'spec_helper'

describe "videos/show" do
  before(:each) do
    @video = assign(:video, stub_model(Video,
      :title => "Title",
      :description => "Description",
      :provider => "Provider",
      :yt_video_id => "Yt Video",
      :url => "Url",
      :is_complete => false,
      :continue => "Continue"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Description/)
    rendered.should match(/Provider/)
    rendered.should match(/Yt Video/)
    rendered.should match(/Url/)
    rendered.should match(/false/)
    rendered.should match(/Continue/)
  end
end
