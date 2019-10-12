class WebArticleController < ApplicationController
  def index
    @web_articles = WebArticle.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  def show
    @web_article = WebArticle.find(params[:id])
  end
end
