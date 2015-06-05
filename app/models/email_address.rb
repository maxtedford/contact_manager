class EmailAddress < ActiveRecord::Base
  belongs_to :person
  
  validates :address,
    presence: true
  validates :person_id,
    presence: true
end
