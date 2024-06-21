require 'rails_helper'

RSpec.describe "Payments", type: :request do
  let!(:user) { FactoryBot.create :user }

  before { sign_in user }

  describe "GET /payments" do
    it "returns a success response" do
      get payments_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /payments" do
    let!(:person) { FactoryBot.create :person }

    context "when creating a payment fails" do
      it "does not create a new payment" do
        expect {
          post payments_path, params: {
            payment: {
              amount: nil, # Invalid amount
              paid_at: Date.today, # Invalid paid_at
              person_id: person.id
            }
          }
        }.to_not change(Payment, :count)
        expect(response).to have_http_status(422) # Unprocessable Entity
      end
    end

    context "when creating a payment succeeds" do
      it "creates a new payment" do
        expect {
          post payments_path, params: {
            payment: {
              amount: 100,
              paid_at: Date.today,
              person_id: person.id
            }
          }
        }.to change(Payment, :count).by(1)
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "DELETE /payments/:id" do
    let!(:payment) { FactoryBot.create(:payment) }

    it "deletes the specified payment" do
      expect {
        delete payment_path(payment)
      }.to change(Payment, :count).by(-1)
      expect(response).to have_http_status(302)
    end
  end
end
