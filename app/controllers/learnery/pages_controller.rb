module Learnery
class PagesController < ApplicationController
  include Learnery::RsvpHelper

  def show
    if params[:id] =~/^\w+$/ then
      render params[:id]
    end
  end
end
end
