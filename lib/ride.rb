class Ride

  attr_reader :name, :distance, :loop, :terrain


  def initialize(ride_deets)
    @name = ride_deets[:name]
    @distance = ride_deets[:distance]
    @loop = ride_deets[:loop]
    @terrain = ride_deets[:terrain]
  end

  def loop?
    @loop
  end

  def total_distance
    @loop ? @distance : @distance * 2
  end

end