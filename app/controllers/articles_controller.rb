class ArticlesController < ApplicationController
  def show
    # reservation = Reservation.find(params[:id])
    # hotel = reservation.hotel
    # article = hotel.articles.where(title: 'house_manual')
    article = Article.find(params[:id])
    send_file("app/assets/articles/#{article.title}.pdf", disposition: :inline, type: "application/pdf")
  end
end
