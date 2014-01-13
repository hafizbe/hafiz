require 'spec_helper'

describe "recitators/show" do
  before(:each) do
    @recitator = assign(:recitator, stub_model(Recitator,
      :name => "Name",
      :value => "Value"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Value/)
  end
end
