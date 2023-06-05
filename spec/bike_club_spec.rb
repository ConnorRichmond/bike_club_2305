require './lib/ride' 
require './lib/biker'
require './lib/bike_club'

club1 = BikeClub.new('Bikers United Test Takers')
club2 = BikeClub.new('EEMMMSS')
biker1 = Biker.new("Kenny", 30)
biker2 = Biker.new("Athena", 16)
biker3 = Biker.new("Max", 20)
biker4 = Biker.new("Mike", 10)
ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
ride3 = Ride.new({name: "Super Duper", distance: 15.0, loop: false, terrain: :flat})
ride4 = Ride.new({name: "Mountain", distance: 8.7, loop: true, terrain: :mountain})
ride5 = Ride.new({name: "All", distance: 8.0, loop: true, terrain: :all})

describe 'BikeClub' do

  it 'has names' do
    expect(club1.name).to eq('Bikers United Test Takers')
    expect(club2.name).to eq('EEMMMSS')
  end

  it 'adds bikers to club' do
    expect(club1.bikers).to eq([])
    expect(club2.bikers).to eq([])

    club1.add_biker(biker1)
    club1.add_biker(biker2)
    club2.add_biker(biker3)
    club2.add_biker(biker4)

    expect(club1.bikers).to eq([biker1, biker2])
    expect(club2.bikers).to eq([biker3, biker4])
  end

  it 'bikers have terrain' do
    biker1.learn_terrain!(:hills)
    biker1.learn_terrain!(:mountain)
    biker2.learn_terrain!(:flat)
    biker2.learn_terrain!(:mountain)
    biker3.learn_terrain!(:gravel)
    biker3.learn_terrain!(:hills)
    biker4.learn_terrain!(:gravel)
    biker4.learn_terrain!(:flat)
    expect(biker1.acceptable_terrain).to eq([:hills, :mountain])
    expect(biker2.acceptable_terrain).to eq([:flat, :mountain])
    expect(biker3.acceptable_terrain).to eq([:gravel, :hills])
    expect(biker4.acceptable_terrain).to eq([:gravel, :flat])
  end

  it 'logs rides' do
    biker1.log_ride(ride1, 95.2)
    biker1.log_ride(ride4, 25.3)
    biker2.log_ride(ride3, 30.5)
    biker2.log_ride(ride4, 22.0)
    biker3.log_ride(ride1, 76.8)
    biker3.log_ride(ride2, 16.8)
    biker4.log_ride(ride2, 19.6)
    biker4.log_ride(ride3, 34.2)

    expect(biker1.rides).to eq({ride1 => [95.2], ride4 => [25.3]})
    expect(biker2.rides).to eq({ride4 => [22.0]})
    expect(biker3.rides).to eq({ride2 => [16.8]})
    expect(biker4.rides).to eq({})
  end

  it 'shows who has most rides' do
    expect(club1.most_rides).to eq(biker1)
    expect(club2.most_rides).to eq(biker3)
  end

  it 'shows best time' do
    expect(club1.best_time(ride4)).to eq(biker2)
  end

  it 'shows elegible bikers' do
    expect(club1.eligible_bikers(ride1)).to eq([biker1])
    expect(club1.eligible_bikers(ride2)).to eq([])
    expect(club1.eligible_bikers(ride3)).to eq([])
    expect(club1.eligible_bikers(ride4)).to eq([biker1, biker2])

    expect(club2.eligible_bikers(ride1)).to eq([])
    expect(club2.eligible_bikers(ride2)).to eq([biker3])
    expect(club2.eligible_bikers(ride3)).to eq([])
    expect(club2.eligible_bikers(ride4)).to eq([])
  end

end