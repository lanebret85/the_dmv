require 'spec_helper'

RSpec.describe Facility do
  before(:each) do
    @facility = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
  end
  describe '#initialize' do
    it 'can initialize' do
      expect(@facility).to be_an_instance_of(Facility)
      expect(@facility.name).to eq('DMV Tremont Branch')
      expect(@facility.address).to eq('2855 Tremont Place Suite 118 Denver CO 80205')
      expect(@facility.phone).to eq('(720) 865-4600')
      expect(@facility.services).to eq([])
    end
  end

  describe '#add service' do
    it 'can add available services' do
      expect(@facility.services).to eq([])
      @facility.add_service('New Drivers License')
      @facility.add_service('Renew Drivers License')
      @facility.add_service('Vehicle Registration')
      expect(@facility.services).to eq(['New Drivers License', 'Renew Drivers License', 'Vehicle Registration'])
    end
  end

  describe "#register_vehicle, #registered_vehicles, and #collected_fees" do
    describe "it can register vehicles, return an array of registered vehicles, and return collected fees" do
      facility_1 = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
      facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})
      
      cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
      bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
      camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )
      
      facility_1.add_service('Vehicle Registration')
      
      expect(cruz.registration_date).to eq(nil)
      expect(facility_1.registered_vehicles).to eq([])
      expect(facility_1.collected_fees).to eq(0)
      
      facility_1.register_vehicle(cruz)
      
      expect(facility_1.register_vehicle(cruz)).to eq([cruz])
      expect(cruz.registration_date).to eq(<Date: 2023-01-12 ((2459957j,0s,0n),+0s,2299161j)>)
      expect(cruz.plate_type).to eq(:regular)
      expect(facility_1.registered_vehicles).to eq([cruz])
      expect(facility_1.collected_fees).to eq(100)

      facility_1.register_vehicle(camaro)
      
      expect(facility_1.register_vehicle(camaro)).to eq([cruz, camaro])
      expect(camaro.registration_date). to eq(<Date: 2023-01-12 ((2459957j,0s,0n),+0s,2299161j)>)
      expect(camaro.plate_type).to eq(:antique)
      
      facility_1.register_vehicle(bolt)
      
      expect(facility_1.register_vehicle(bolt)).to eq([cruz, camaro, bolt])
      expect(bolt.registration_date).to eq(<Date: 2023-01-12 ((2459957j,0s,0n),+0s,2299161j)>)
      expect(bolt.plate_type).to eq(:ev)
      expect(facility_1.registered_vehicles).to eq([cruz, camaro, bolt])
      expect(facility_1.collected_fees).to eq(325)
      
      # facility_2.registered_vehicles
      #=> []
      
      # facility_2.services
      #=> []
      
      # facility_2.register_vehicle(bolt)
      #=> nil
      
      # facility_2.registered_vehicles
      #=> []
      
      # facility_2.collected_fees
      #=> 0
    end
  end
end
