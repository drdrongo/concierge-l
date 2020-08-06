class ArticlesController < ApplicationController
  def show
    article = Article.find(params[:id])
    send_file("app/assets/articles/#{article.title}.pdf", disposition: :inline, type: "application/pdf")
  end
end
