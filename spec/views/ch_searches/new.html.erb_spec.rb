require 'spec_helper'

describe "ch_searches/new" do
  before(:each) do
    assign(:ch_search, stub_model(ChSearch,
      :keywords => "MyString",
      :channel_type => "MyString",
      :tags => "MyString",
      :categories => "MyString",
      :language => "MyString"
    ).as_new_record)
  end

  it "renders new ch_search form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ch_searches_path, :method => "post" do
      assert_select "input#ch_search_keywords", :name => "ch_search[keywords]"
      assert_select "input#ch_search_channel_type", :name => "ch_search[channel_type]"
      assert_select "input#ch_search_tags", :name => "ch_search[tags]"
      assert_select "input#ch_search_categories", :name => "ch_search[categories]"
      assert_select "input#ch_search_language", :name => "ch_search[language]"
    end
  end
end
