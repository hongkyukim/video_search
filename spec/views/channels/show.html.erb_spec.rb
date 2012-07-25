require 'spec_helper'

describe "channels/show" do
  before(:each) do
    @channel = assign(:channel, stub_model(Channel,
      :name => "Name",
      :channel_type => "Channel Type",
      :tags => "Tags",
      :categories => "Categories",
      :language => "Language"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Channel Type/)
    rendered.should match(/Tags/)
    rendered.should match(/Categories/)
    rendered.should match(/Language/)
  end
end
