class Payment < ApplicationRecord
  belongs_to :person

  after_save :update_person_amount
  after_destroy :update_person_amount
  
  validates :amount, presence: true

  def update_person_amount
    person.update_amount
    person.save
  end
end
