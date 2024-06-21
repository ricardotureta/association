class MyWorker
    include Sidekiq::Worker
  
    def perform(*args)
      # código para realizar o trabalho
    end
  end