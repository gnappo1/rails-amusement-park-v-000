class AttractionsController < ApplicationController
  before_action :set_attraction, only: [:show, :edit, :update, :destroy, :ride]

  def index
    @attractions = Attraction.all
  end

  def new
    @attraction = Attraction.new
  end

  def create
    @attraction = Attraction.new(attraction_params)
    if @attraction.save
      flash[:notice] = "Attraction was successfully created."
      session[:attraction_id] = @attraction.id
      redirect_to @attraction
    else
      flash[:error] = error_parser(@attraction.errors.messages.first)
      render :new
    end
  end

  def show
    redirect_to root_path unless logged_in
  end

  def ride
    @ride = Ride.new(user_id: current_user.id, attraction_id: @attraction.id)
    flash[:notice] = @ride.take_ride
    redirect_to user_path(current_user)
  end

  def edit
  end

  def update
    if @attraction.update(attraction_params)
      flash[:notice] = "Attraction was successfully updated."
      redirect_to @attraction
    else
      flash[:error] = error_parser(@attraction.errors.messages.first)
      render :edit
    end
  end

  def destroy
    @attraction.destroy
    redirect_to attractions_path
  end

  private

  def attraction_params
    params.require(:attraction).permit(:name, :tickets, :nausea_rating, :happiness_rating, :min_height)
  end

  def set_attraction
    @attraction = Attraction.find_by(id: params[:id])
  end
end
