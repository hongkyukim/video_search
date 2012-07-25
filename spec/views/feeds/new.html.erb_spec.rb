require 'spec_helper'

describe "feeds/new" do
  before(:each) do
    assign(:feed, stub_model(Feed,
      :name => "MyString",
      :feedtype => "MyString",
      :queries => "MyString",
      :options => "MyString",
      :keywords => "MyString",
      :tags => "MyString",
      :categories => "MyString"
    ).as_new_record)
  end

  it "renders new feed form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => feeds_path, :method => "post" do
      assert_select "input#feed_name", :name => "feed[name]"
      assert_select "input#feed_feedtype", :name => "feed[feedtype]"
      assert_select "input#feed_queries", :name => "feed[queries]"
      assert_select "input#feed_options", :name => "feed[options]"
      assert_select "input#feed_keywords", :name => "feed[keywords]"
      assert_select "input#feed_tags", :name => "feed[tags]"
      assert_select "input#feed_categories", :name => "feed[categories]"
    end
  end
end
