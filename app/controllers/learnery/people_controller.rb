module Learnery
class PeopleController < ApplicationController
  include Learnery::AuthenticationHelper
  include Learnery::RsvpHelper

  before_filter :authenticate_user!
  before_filter :admin_only,  :only => [ :index, :show, :edit, :update ]
  before_filter :find_person, :only =>  [ :show, :edit, :update ]

  def index
    @people = User.all
  end

  def show
  end

  def edit
  end

  def update
    debugger
    if @person.update(person_params)
      redirect_to people_path, notice: 'Person was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private


  def find_person
    @person = User.find(params[:id])
  end

  def person_params
    params.require(:user).permit(:firstname, :lastname, :nickname, :email, :admin)
  end
end
end
