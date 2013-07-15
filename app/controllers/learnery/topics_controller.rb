module Learnery
class TopicsController < ApplicationController
  include Learnery::RsvpHelper
  include Learnery::AuthenticationHelper

  before_action :set_event,   only: [:new, :create]
  before_action :set_topic,   only: [:show, :edit, :update, :destroy]
  before_filter :user_only,   only: [:new, :create, :edit, :update, :destroy]

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
  end

  # GET /topics/new
  def new
    if @event
      @topic = @event.suggested_topics.build
    else
      @topic = Topic.new
    end
    @topic.suggested_by = current_user
  end

  # GET /topics/1/edit
  def edit
    @event = @topic.event
  end

  # POST /topics
  # POST /topics.json
  def create
    if @event
      params[:topic][:event_id] = @event.id
    end
    @topic = Topic.new(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic.event, notice: t('topics.successfully_created')}
        format.json { render action: 'show', status: :created, location: @topic }
      else
        format.html { render action: 'new' }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: t('topics.successfully_updated')}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end
    def set_event
      @event = Event.find(params[:event_id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:name, :description, :event_id, :suggested_by_id, :presented_by_id)
    end
end
end
