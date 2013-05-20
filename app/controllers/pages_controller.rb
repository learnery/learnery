class PagesController < ApplicationController
  def show
    if params[:id] =~/^\w+$/ then
      render params[:id]
    end
  end
end
