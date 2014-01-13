require 'spec_helper'

describe "recitators/index" do
  before(:each) do
    assign(:recitators, [
      stub_model(Recitator,
        :name => "Name",
        :value => "Value"
      ),
      stub_model(Recitator,
        :name => "Name",
        :value => "Value"
      )
    ])
  end

  it "renders a list of recitators" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Value".to_s, :count => 2
  end
end
