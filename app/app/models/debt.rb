class Debt < ApplicationRecord
  belongs_to :person

  validates :amount, presence: true

  after_save :update_person_amount
  after_destroy :update_person_amount
  
  validates :amount, presence: true

  def update_person_amount
    person.update_amount
    person.save
  end
end
