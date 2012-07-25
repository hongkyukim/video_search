require 'spec_helper'

describe "channels/index" do
  before(:each) do
    assign(:channels, [
      stub_model(Channel,
        :name => "Name",
        :channel_type => "Channel Type",
        :tags => "Tags",
        :categories => "Categories",
        :language => "Language"
      ),
      stub_model(Channel,
        :name => "Name",
        :channel_type => "Channel Type",
        :tags => "Tags",
        :categories => "Categories",
        :language => "Language"
      )
    ])
  end

  it "renders a list of channels" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Channel Type".to_s, :count => 2
    assert_select "tr>td", :text => "Tags".to_s, :count => 2
    assert_select "tr>td", :text => "Categories".to_s, :count => 2
    assert_select "tr>td", :text => "Language".to_s, :count => 2
  end
end
