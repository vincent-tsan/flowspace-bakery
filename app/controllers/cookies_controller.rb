class CookiesController < ApplicationController
  before_action :authenticate_user!

  def new
    @oven = current_user.ovens.find_by!(id: params[:oven_id])
    if @oven.cookies.count > 0
      redirect_to @oven, alert: 'A cookie is already in the oven!'
    else
      @cookie = @oven.cookies.build
    end
  end

  def create
    @oven = current_user.ovens.find_by!(id: params[:oven_id])

    for i in 1..params[:quantity].to_i
      @cookie = @oven.cookies.create!(cookie_params)
      # Background worker to perform baking cookie by update
      # status column when cookie is ready.
      ChefWorker.perform_in(1.minutes, @cookie.id)
    end
    redirect_to oven_path(@oven)
  end

  private

  def cookie_params
    params.require(:cookie).permit(:fillings)
  end
end
