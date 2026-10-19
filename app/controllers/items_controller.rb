
class ItemsController < ApplicationController
  def index
    @query = params[:q].to_s.strip

    @items = Item.where(item_type: "movie")
                 .where.not(tmdb_rating: nil)

    @items = @items.where("title ILIKE ?", "%#{@query}%") if @query.present?

    @items = @items.order(tmdb_rating: :desc, title: :asc)
  end

  def show
    @item = Item.find(params[:id])
  end
end
