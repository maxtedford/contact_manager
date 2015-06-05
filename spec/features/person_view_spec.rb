require 'rails_helper'

describe 'the person view', type: :feature do
  
  let(:person) { Person.create(first_name: "John", last_name: "Doe") }
  
  before(:each) do
    person.phone_numbers.create(number: "555-1234")
    person.phone_numbers.create(number: "555-9876")
    visit person_path(person)
  end
  
  it "shows a list of numbers on the person page" do
    person.phone_numbers.each do |p_n|
      expect(page).to have_content(p_n.number)
    end
  end
end
