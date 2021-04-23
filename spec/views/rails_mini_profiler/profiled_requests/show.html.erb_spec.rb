require 'rails_helper'

RSpec.describe "profiled_requests/show", type: :view do
  before(:each) do
    @profiled_request = assign(:profiled_request, ProfiledRequest.create!(
      status: "",
      duration: "",
      path: "Path",
      headers: "Headers",
      body: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Path/)
    expect(rendered).to match(/Headers/)
    expect(rendered).to match(/MyText/)
  end
end
