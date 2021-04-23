
class ProfilesController < ApplicationController
  def show
    render(json: { id: 1})
  end
end
