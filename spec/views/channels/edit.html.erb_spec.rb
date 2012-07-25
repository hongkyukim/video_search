require 'spec_helper'

describe "channels/edit" do
  before(:each) do
    @channel = assign(:channel, stub_model(Channel,
      :name => "MyString",
      :channel_type => "MyString",
      :tags => "MyString",
      :categories => "MyString",
      :language => "MyString"
    ))
  end

  it "renders the edit channel form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => channels_path(@channel), :method => "post" do
      assert_select "input#channel_name", :name => "channel[name]"
      assert_select "input#channel_channel_type", :name => "channel[channel_type]"
      assert_select "input#channel_tags", :name => "channel[tags]"
      assert_select "input#channel_categories", :name => "channel[categories]"
      assert_select "input#channel_language", :name => "channel[language]"
    end
  end
end
