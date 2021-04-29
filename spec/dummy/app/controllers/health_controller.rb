# frozen_string_literal: true

class ProfilesController < ApplicationController
  def ping
    head(:ok)
  end
end
