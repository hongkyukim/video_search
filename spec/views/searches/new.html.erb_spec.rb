require 'spec_helper'

describe "searches/new" do
  before(:each) do
    assign(:search, stub_model(Search,
      :keywords => "MyString",
      :channel_type => "MyString",
      :tags => "MyString",
      :categories => "MyString",
      :language => "MyString"
    ).as_new_record)
  end

  it "renders new search form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => searches_path, :method => "post" do
      assert_select "input#search_keywords", :name => "search[keywords]"
      assert_select "input#search_channel_type", :name => "search[channel_type]"
      assert_select "input#search_tags", :name => "search[tags]"
      assert_select "input#search_categories", :name => "search[categories]"
      assert_select "input#search_language", :name => "search[language]"
    end
  end
end
