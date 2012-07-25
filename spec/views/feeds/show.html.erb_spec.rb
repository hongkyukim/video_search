require 'spec_helper'

describe "feeds/show" do
  before(:each) do
    @feed = assign(:feed, stub_model(Feed,
      :name => "Name",
      :feedtype => "Feedtype",
      :queries => "Queries",
      :options => "Options",
      :keywords => "Keywords",
      :tags => "Tags",
      :categories => "Categories"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Feedtype/)
    rendered.should match(/Queries/)
    rendered.should match(/Options/)
    rendered.should match(/Keywords/)
    rendered.should match(/Tags/)
    rendered.should match(/Categories/)
  end
end
