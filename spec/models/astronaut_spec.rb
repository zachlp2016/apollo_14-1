require 'rails_helper'

describe Astronaut, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should validate_presence_of :job }
  end

  describe 'Relationships' do
    it { should have_many :astronaut_missions}
    it { should have_many :missions}
  end

  describe 'Class-Methods' do

    before :each do
      @astronaut_1 = Astronaut.create!(name: 'Smith', age: 33, job: "Engineer")
      @astronaut_2= Astronaut.create!(name: 'Sara', age: 28, job: "Captain")
      @astronaut_3 = Astronaut.create!(name: 'Martha', age: 55, job: "CEO")
    end

    it 'Class-Methods' do
      actual = Astronaut.average_age.round(2)
      expected = 38.67
      expect(actual).to eq(expected)
    end

    it 'Instance-Methods' do
      actual = @astronaut_1.total_time_in_space
      expected = 380
      expect(actual).to eq(expected)
    end
  end
end
