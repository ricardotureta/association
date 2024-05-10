require_relative '../services/dashboard_service'

class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @active_people_pie_chart = DashboardService.find_people_counts

    # Total somando todos associados ativos
    active_people_ids = DashboardService.find_people_active
    @total_debts = Debt.where(person_id: active_people_ids).sum(:amount)
    @total_payments = Payment.where(person_id: active_people_ids).sum(:amount)
    @balance = @total_payments - @total_debts

    # últimos lançamentos
    # no formato somente id + amount para o kickchart
    @last_debts = Debt.order(created_at: :desc).limit(10).map do |debt|
      [debt.id, debt.amount]
    end
    @last_payments = Payment.order(created_at: :desc).limit(10).map do |payment|
      [payment.id, payment.amount]
    end

    # últimos associados cadastrados pelo usuário atual
    @my_people = Person.where(user: current_user).order(:created_at).limit(10)

    people = Person.all.select do |person|
      person.balance > 0
    end.sort_by do |person|
      person.balance
    end

    # associado com maior saldo
    @top_person = people.last

    # associado com menor saldo
    @bottom_person = people.first
  end
end