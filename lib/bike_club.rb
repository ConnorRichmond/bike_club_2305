class BikeClub
  attr_reader :name, :bikers

  def initialize(name)
    @name = name
    @bikers = []
  end

  def add_biker(biker)
    @bikers << biker
  end

  def most_rides
    @bikers.max_by { |biker| biker.rides.length }
  end

  def best_time(ride)
    best_biker = nil
    @bikers.each do |biker|
      time = biker.personal_record(ride)
      if time && (best_biker.nil? || time < best_biker.personal_record(ride))
        best_biker = biker
      end
    end
    best_biker
  end

  def eligible_bikers(ride)
    @bikers.select do |biker|
      biker.acceptable_terrain.include?(ride.terrain) && ride.total_distance <= biker.max_distance
    end
  end
  
end