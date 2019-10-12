class WebArticleController < ApplicationController
  before_action :find_articles, only: [:index]

  def index
  end

  def show
    @web_article = WebArticle.find(params[:id])
  end

  private

  def find_articles
    @search_term = params.dig(:web_article, :title)
    @web_articles = WebArticle.order(created_at: :desc).includes(web_link: :web_domain)
    @web_articles = @web_articles.where("title ILIKE ?", "% %#{@search_term}%") if @search_term.present?
    @web_articles = @web_articles.paginate(page: params[:page])
  end
end
