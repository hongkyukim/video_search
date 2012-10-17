require 'spec_helper'

describe "searches/show" do
  before(:each) do
    @search = assign(:search, stub_model(Search,
      :keywords => "Keywords",
      :channel_type => "Channel Type",
      :tags => "Tags",
      :categories => "Categories",
      :language => "Language"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Keywords/)
    rendered.should match(/Channel Type/)
    rendered.should match(/Tags/)
    rendered.should match(/Categories/)
    rendered.should match(/Language/)
  end
end
