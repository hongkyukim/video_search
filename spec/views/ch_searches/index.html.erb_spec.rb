require 'spec_helper'

describe "ch_searches/index" do
  before(:each) do
    assign(:ch_searches, [
      stub_model(ChSearch,
        :keywords => "Keywords",
        :channel_type => "Channel Type",
        :tags => "Tags",
        :categories => "Categories",
        :language => "Language"
      ),
      stub_model(ChSearch,
        :keywords => "Keywords",
        :channel_type => "Channel Type",
        :tags => "Tags",
        :categories => "Categories",
        :language => "Language"
      )
    ])
  end

  it "renders a list of ch_searches" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Keywords".to_s, :count => 2
    assert_select "tr>td", :text => "Channel Type".to_s, :count => 2
    assert_select "tr>td", :text => "Tags".to_s, :count => 2
    assert_select "tr>td", :text => "Categories".to_s, :count => 2
    assert_select "tr>td", :text => "Language".to_s, :count => 2
  end
end
