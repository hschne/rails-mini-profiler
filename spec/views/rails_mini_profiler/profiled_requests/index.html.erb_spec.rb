require 'rails_helper'

RSpec.describe "profiled_requests/index", type: :view do
  before(:each) do
    assign(:profiled_requests, [
      ProfiledRequest.create!(
        status: "",
        duration: "",
        path: "Path",
        headers: "Headers",
        body: "MyText"
      ),
      ProfiledRequest.create!(
        status: "",
        duration: "",
        path: "Path",
        headers: "Headers",
        body: "MyText"
      )
    ])
  end

  it "renders a list of profiled_requests" do
    render
    assert_select "tr>td", text: "".to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
    assert_select "tr>td", text: "Path".to_s, count: 2
    assert_select "tr>td", text: "Headers".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
  end
end
