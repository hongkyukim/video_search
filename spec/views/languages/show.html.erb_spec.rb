require 'spec_helper'

describe "languages/show" do
  before(:each) do
    @language = assign(:language, stub_model(Language,
      :name => "Name",
      :fullname => "Fullname",
      :shortname => "Shortname"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Fullname/)
    rendered.should match(/Shortname/)
  end
end
