require 'spec_helper'

describe "recitators/edit" do
  before(:each) do
    @recitator = assign(:recitator, stub_model(Recitator,
      :name => "MyString",
      :value => "MyString"
    ))
  end

  it "renders the edit recitator form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", recitator_path(@recitator), "post" do
      assert_select "input#recitator_name[name=?]", "recitator[name]"
      assert_select "input#recitator_value[name=?]", "recitator[value]"
    end
  end
end
