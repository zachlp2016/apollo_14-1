RSpec.describe 'Astronaut Index Page', type: :feature do
  context 'As a visitor' do
    describe 'When I visit the Astronaut index page'
      before :each do
        @astronaut_1 = Astronaut.create!(name: 'Smith', age: 33, job: "Engineer")
        @astronaut_2= Astronaut.create!(name: 'Sara', age: 28, job: "Captain")
        @astronaut_3 = Astronaut.create!(name: 'Martha', age: 55, job: "CEO")
        @mission_1 = Mission.create!(title: "Rover 1", time_in_space: 389)
        @mission_2 = Mission.create!(title: "Rover 2", time_in_space: 244)
        @mission_3 = Mission.create!(title: "Rover 3", time_in_space: 360)
        @astronaut_1.missions << @mission_1
        @astronaut_1.missions << @mission_2
        @astronaut_2.missions << @mission_2
        @astronaut_2.missions << @mission_3
        @astronaut_3.missions << @mission_1
        @astronaut_3.missions << @mission_3

      end

    it 'I see a list of Astronauts' do

      visit astronauts_path


      within "#astronaut-id-#{@astronaut_1.id}" do
        expect(page).to have_content('Name: Smith')
        expect(page).to have_content('Age: 33')
        expect(page).to have_content('Job: Engineer')
        expect(page).to have_content("Total Time in Space: #{@astronaut_1.total_time_in_space}")

      end

      within "#astronaut-id-#{@astronaut_2.id}" do
        expect(page).to have_content('Name: Sara')
        expect(page).to have_content('Age: 28')
        expect(page).to have_content('Job: Captain')
        expect(page).to have_content("Total Time in Space: #{@astronaut_2.total_time_in_space}")
      end

      within "#astronaut-id-#{@astronaut_3.id}" do
        expect(page).to have_content('Name: Martha')
        expect(page).to have_content('Age: 55')
        expect(page).to have_content('Job: CEO')
        expect(page).to have_content("Total Time in Space: #{@astronaut_3.total_time_in_space}")
      end

    end

    it 'I see a average age of all of the astronauts' do
      visit astronauts_path

      within "#average-age" do
        expect(page).to have_content("Average age of Astronauts: #{Astronaut.average_age.round(2)}")
      end
    end

    it 'sees a list of space missions' do
      visit astronauts_path


      within "#astronaut-mission-#{@astronaut_1.id}" do
        expect(page).to have_content("#{@mission_1.title}")
        expect(page).to have_content("#{@mission_2.title}")
      end

      within "#astronaut-mission-#{@astronaut_2.id}" do
        expect(page).to have_content("#{@mission_2.title}")
        expect(page).to have_content("#{@mission_3.title}")
      end

      within "#astronaut-mission-#{@astronaut_3.id}" do
        expect(page).to have_content("#{@mission_1.title}")
        expect(page).to have_content("#{@mission_3.title}")
      end
    end
  end
end
#
# As a visitor,
# When I visit '/astronauts'
# I see the total time in space for each astronaut.
# (e.g. "Name: Neil Armstrong, Age: 37, Job: Commander, Total Time in Space: 760 days")
