require 'spec_helper'

describe "feeds/index" do
  before(:each) do
    assign(:feeds, [
      stub_model(Feed,
        :name => "Name",
        :feedtype => "Feedtype",
        :queries => "Queries",
        :options => "Options",
        :keywords => "Keywords",
        :tags => "Tags",
        :categories => "Categories"
      ),
      stub_model(Feed,
        :name => "Name",
        :feedtype => "Feedtype",
        :queries => "Queries",
        :options => "Options",
        :keywords => "Keywords",
        :tags => "Tags",
        :categories => "Categories"
      )
    ])
  end

  it "renders a list of feeds" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Feedtype".to_s, :count => 2
    assert_select "tr>td", :text => "Queries".to_s, :count => 2
    assert_select "tr>td", :text => "Options".to_s, :count => 2
    assert_select "tr>td", :text => "Keywords".to_s, :count => 2
    assert_select "tr>td", :text => "Tags".to_s, :count => 2
    assert_select "tr>td", :text => "Categories".to_s, :count => 2
  end
end
