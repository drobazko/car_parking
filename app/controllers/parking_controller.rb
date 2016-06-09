require 'load_dependencies'

class ParkingController < ApplicationController
  before_filter :default_fill, only: :index

  def index
  end

  def fill
    @parking = ParkingHandler.new(
        sedan_number: params[:sedan_number].to_i, 
        disabled_number: params[:disabled_number].to_i, 
        truck_number: params[:truck_number].to_i
      )

    session[:parking] = @parking.to_yaml
  end

  def park_car
    @parking = YAML.load(session[:parking])

    begin
      @parking.park!(Car.new(params[:car_type].to_sym))
      session[:parking] = @parking.to_yaml
    rescue Exception => e
      @msg = e
      render partial: 'error' and return
    end

    render 'fill'
  end

  def free
    @parking = YAML.load(session[:parking])
    @parking.free_place_by_index!(params[:index].to_i)
    session[:parking] = @parking.to_yaml
    render 'fill'
  end

  def random
    @parking = ParkingHandler.random_init
    session[:parking] = @parking.to_yaml
    render 'fill'
  end

  private 

  def default_fill
    @parking = ParkingHandler.new
    @parking = YAML.load(session[:parking]) if session[:parking]

    session[:parking] = @parking.to_yaml
  end
end
