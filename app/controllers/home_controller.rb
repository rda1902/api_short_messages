class HomeController < ApplicationController

  protect_from_forgery with: :exception
  before_action :set_dates, only: :index

  def index
    @top_by_count_of_messages = User.top_by_count_of_messages(@dates)
    @top_by_message_votes = User.top_by_vote_of_messages(@dates)
    @top_by_average_message_rating = User.top_by_average_message_rating(@dates)
  end

  private

  def set_dates
    @dates = {}
    @dates[:start] = Date.strptime(params[:start]) if params[:start].present?
    @dates[:end] = Date.strptime(params[:end]) if params[:end].present?
  end

end
