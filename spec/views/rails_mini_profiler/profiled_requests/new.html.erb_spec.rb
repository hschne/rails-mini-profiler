require 'rails_helper'

RSpec.describe "profiled_requests/new", type: :view do
  before(:each) do
    assign(:profiled_request, ProfiledRequest.new(
      status: "",
      duration: "",
      path: "MyString",
      headers: "MyString",
      body: "MyText"
    ))
  end

  it "renders new profiled_request form" do
    render

    assert_select "form[action=?][method=?]", profiled_requests_path, "post" do

      assert_select "input[name=?]", "profiled_request[status]"

      assert_select "input[name=?]", "profiled_request[duration]"

      assert_select "input[name=?]", "profiled_request[path]"

      assert_select "input[name=?]", "profiled_request[headers]"

      assert_select "textarea[name=?]", "profiled_request[body]"
    end
  end
end
