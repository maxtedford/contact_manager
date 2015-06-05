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
  
  it "has a link to add a new phone number" do
    expect(page).to have_link("New", href: new_phone_number_path(person_id: person.id))
  end
  
  it "Adds a new phone number" do
    page.click_link("New")
    page.fill_in("Number", with: "555-8888")
    page.click_button("Create Phone number")
    expect(current_path).to eq(person_path(person))
    expect(page).to have_content("555-8888")
  end
end
