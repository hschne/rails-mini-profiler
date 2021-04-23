require 'rails_helper'

RSpec.describe "profiled_requests/edit", type: :view do
  before(:each) do
    @profiled_request = assign(:profiled_request, ProfiledRequest.create!(
      status: "",
      duration: "",
      path: "MyString",
      headers: "MyString",
      body: "MyText"
    ))
  end

  it "renders the edit profiled_request form" do
    render

    assert_select "form[action=?][method=?]", profiled_request_path(@profiled_request), "post" do

      assert_select "input[name=?]", "profiled_request[status]"

      assert_select "input[name=?]", "profiled_request[duration]"

      assert_select "input[name=?]", "profiled_request[path]"

      assert_select "input[name=?]", "profiled_request[headers]"

      assert_select "textarea[name=?]", "profiled_request[body]"
    end
  end
end
