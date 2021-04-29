require 'rails_helper'

RSpec.describe "movies/index", type: :view do
  before(:each) do
    assign(:movies, [
      Movie.create!(
        title: "Title",
        imdb_id: "Imdb",
        popularity: "9.99",
        budget: "9.99",
        revenue: "9.99",
        runtime: "9.99"
      ),
      Movie.create!(
        title: "Title",
        imdb_id: "Imdb",
        popularity: "9.99",
        budget: "9.99",
        revenue: "9.99",
        runtime: "9.99"
      )
    ])
  end

  it "renders a list of movies" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "Imdb".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
  end
end
