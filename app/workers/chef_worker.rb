class ChefWorker
  include Sidekiq::Worker

  def perform(*args)
     @cookie_id = args[0]
     @cookie = Cookie.find(@cookie_id)
     @cookie.update_attributes(status: 1)
  end
end
