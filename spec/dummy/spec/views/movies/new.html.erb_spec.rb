require 'rails_helper'

RSpec.describe "movies/new", type: :view do
  before(:each) do
    assign(:movie, Movie.new(
      title: "MyString",
      imdb_id: "MyString",
      popularity: "9.99",
      budget: "9.99",
      revenue: "9.99",
      runtime: "9.99"
    ))
  end

  it "renders new movie form" do
    render

    assert_select "form[action=?][method=?]", movies_path, "post" do

      assert_select "input[name=?]", "movie[title]"

      assert_select "input[name=?]", "movie[imdb_id]"

      assert_select "input[name=?]", "movie[popularity]"

      assert_select "input[name=?]", "movie[budget]"

      assert_select "input[name=?]", "movie[revenue]"

      assert_select "input[name=?]", "movie[runtime]"
    end
  end
end
