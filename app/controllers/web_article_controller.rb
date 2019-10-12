class WebArticleController < ApplicationController
  def index
    @web_articles = WebArticle.order(created_at: :desc).paginate(page: params[:page], per_page: 30)
  end

  def show
  end
end
