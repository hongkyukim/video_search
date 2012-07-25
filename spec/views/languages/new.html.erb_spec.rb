require 'spec_helper'

describe "languages/new" do
  before(:each) do
    assign(:language, stub_model(Language,
      :name => "MyString",
      :fullname => "MyString",
      :shortname => "MyString"
    ).as_new_record)
  end

  it "renders new language form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => languages_path, :method => "post" do
      assert_select "input#language_name", :name => "language[name]"
      assert_select "input#language_fullname", :name => "language[fullname]"
      assert_select "input#language_shortname", :name => "language[shortname]"
    end
  end
end
