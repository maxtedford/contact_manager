require 'rails_helper'

RSpec.describe Person, type: :model do
  
  it "is invalid without a first name" do
    person = Person.new(last_name: "Doe")
    expect(person).not_to be_valid
  end
  
  it "is invalid without a last name" do
    person = Person.new(first_name: "Jane")
    expect(person).not_to be_valid
  end
end
