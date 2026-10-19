
class UserItemsController < ApplicationController
  before_action :require_login

  def index
    @user_items = current_user.user_items.includes(:item).order(updated_at: :desc)
  end

  def create
    item = Item.find(params[:item_id])
    user_item = current_user.user_items.find_or_initialize_by(item: item)

    if user_item.persisted?
      redirect_to item_path(item), notice: "This movie is already in your library."
      return
    end

    user_item.status = "want"

    if user_item.save
      redirect_to user_items_path, notice: "Movie added to your library!"
    else
      redirect_to item_path(item), alert: user_item.errors.full_messages.to_sentence
    end
  end

  def update
    user_item = current_user.user_items.find(params[:id])

    if user_item.update(user_item_params)
      redirect_to user_items_path, notice: "Your library entry has been updated."
    else
      redirect_to user_items_path, alert: user_item.errors.full_messages.to_sentence
    end
  end

  private

  def user_item_params
    params.require(:user_item).permit(:status, :rating)
  end

  def require_login
    return if current_user

    redirect_to "/login", alert: "Please log in to access your library."
  end
end
