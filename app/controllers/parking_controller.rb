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
    begin
      @parking = YAML.load(session[:parking])
      @parking.park!(Car.new(params[:car_type].to_sym))
    rescue Exception => e
      @msg = e
      render partial: 'error' and return
    ensure
      session[:parking] = @parking.to_yaml
    end

    render 'fill'
  end

  def free
    @parking = YAML.load(session[:parking])
    @parking.free_place_by_index!(params[:index].to_i) rescue 'No free place for the queue car'
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
