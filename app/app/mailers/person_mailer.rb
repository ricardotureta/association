class PersonMailer < ApplicationMailer
    default from: 'no-reply@association.com'
  
    def balance_report(user)
  
      attachments['balances.csv'] = {
        mime_type: 'text/csv',
        content: BalanceReportService.generate_report
      }
  
      mail to: user.email, subject: 'Relatório de Saldos'
    end
  end