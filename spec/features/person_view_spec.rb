require 'rails_helper'

describe 'phone number', type: :feature do
  
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
  
  it "adds a new phone number" do
    page.click_link("New")
    page.fill_in("Number", with: "555-8888")
    page.click_button("Create Phone number")
    expect(current_path).to eq(person_path(person))
    expect(page).to have_content("555-8888")
  end
  
  it "has links to edit phone numbers" do
    person.phone_numbers.each do |p_n|
      expect(page).to have_link("Edit", href: edit_phone_number_path(p_n))
    end
  end
  
  it "edits a phone number" do
    phone = person.phone_numbers.first
    old_number = phone.number
    
    first(:link, "Edit").click
    page.fill_in("Number", with: "555-1919")
    page.click_button("Update Phone number")
    expect(current_path).to eq(person_path(person))
    expect(page).to have_content("555-1919")
    expect(page).to_not have_content(old_number)
  end
  
  it "has a link to delete the phone number" do
    person.phone_numbers.each do |p_n|
      expect(page).to have_link("Delete", href: phone_number_path(p_n))
    end
  end
end

describe 'phone number', type: :feature do
  
  let(:person) { Person.create(first_name: "Jane", last_name: "Doe") }
  
  before(:each) do
    person.email_addresses.create(address: "abc@abc.com")
    person.email_addresses.create(address: "xyz@xyz.com")
    visit person_path(person)
  end
  
  it "displays each email address as a list item" do
    expect(page).to have_selector("li", text: "abc@abc.com")
    expect(page).to have_selector("li", text: "xyz@xyz.com")
  end
end
