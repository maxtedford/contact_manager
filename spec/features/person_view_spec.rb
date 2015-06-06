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
    expect(page).to have_link("New Phone Number", href: new_phone_number_path(person_id: person.id))
  end
  
  it "adds a new phone number" do
    page.click_link("New Phone Number")
    page.fill_in("Number", with: "555-8888")
    page.click_button("Create Phone number")
    expect(current_path).to eq(person_path(person))
    expect(page).to have_content("555-8888")
  end
  
  it "has links to edit phone numbers" do
    person.phone_numbers.each do |p_n|
      expect(page).to have_link("Edit Phone Number", href: edit_phone_number_path(p_n))
    end
  end
  
  it "edits a phone number" do
    phone = person.phone_numbers.first
    old_number = phone.number
    
    first(:link, "Edit Phone Number").click
    page.fill_in("Number", with: "555-1919")
    page.click_button("Update Phone number")
    expect(current_path).to eq(person_path(person))
    expect(page).to have_content("555-1919")
    expect(page).to_not have_content(old_number)
  end
  
  it "has a link to delete the phone number" do
    person.phone_numbers.each do |p_n|
      expect(page).to have_link("Delete Phone Number", href: phone_number_path(p_n))
    end
  end
end

describe 'email address', type: :feature do

  let(:person) { Person.create(first_name: "John", last_name: "Doe") }
  
  before(:each) do
    person.email_addresses.create(address: "abc@abc.com")
    person.email_addresses.create(address: "xyz@xyz.com")
    visit person_path(person)
  end
  
  it "displays each email address as a list item" do
    expect(page).to have_selector("li", text: "abc@abc.com")
    expect(page).to have_selector("li", text: "xyz@xyz.com")
  end
  
  it "has a new email address link" do
    expect(page).to have_link("New", href: new_email_address_path(person_id: person.id))
    expect(current_path).to eq(person_path(person))
  end
  
  it "can add a new email address" do
    page.click_link("New Email Address")
    page.fill_in("Address", with: "boom@nailedit.com")
    page.click_button("Create Email address")
    expect(current_path).to eq(person_path(person))
    expect(page).to have_content("boom@nailedit.com")
  end
  
  it "has links to edit the email addresses" do
    person.email_addresses.each do |email_address|
      expect(page).to have_link("Edit Email Address", href: edit_email_address_path(email_address))
    end
  end
  
  it "edits an email address" do
    email = person.email_addresses.first
    old_email = email.address
    
    first(:link, "Edit Email Address").click
    page.fill_in("Address", with: "newemail@email.com")
    page.click_button("Update Email address")
    expect(current_path).to eq(person_path(person))
    expect(page).to_not have_content(old_email)
  end
  
  it "has links to delete the email addresses" do
    person.email_addresses.each do |email|
      expect(page).to have_link("Delete", href: email_address_path(email))
    end
  end
  
  it "redirects to the person view after deleting an email address" do
    email_address = person.email_addresses.first.address
    
    first(:link, "Delete Email Address").click
    expect(current_path).to eq(person_path(person))
    expect(page).to_not have_content(email_address)
  end
end
