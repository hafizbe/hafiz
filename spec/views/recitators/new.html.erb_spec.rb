require 'spec_helper'

describe "recitators/new" do
  before(:each) do
    assign(:recitator, stub_model(Recitator,
      :name => "MyString",
      :value => "MyString"
    ).as_new_record)
  end

  it "renders new recitator form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", recitators_path, "post" do
      assert_select "input#recitator_name[name=?]", "recitator[name]"
      assert_select "input#recitator_value[name=?]", "recitator[value]"
    end
  end
end
