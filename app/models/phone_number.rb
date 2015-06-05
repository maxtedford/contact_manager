class PhoneNumber < ActiveRecord::Base
  belongs_to :person
  
  validates :number,
    presence: true
  validates :person_id,
    presence: true
end
