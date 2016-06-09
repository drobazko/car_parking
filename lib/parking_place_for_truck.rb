class ParkingPlaceForTruck < ParkingPlace
  def initialize
    @type = :truck
  end

  def free_for?(car)
    free?
  end
end