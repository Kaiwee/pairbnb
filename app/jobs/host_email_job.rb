class HostEmailJob < ActiveJob::Base
  queue_as :default

  def perform(customer, host, listing)
    # changing the method deliver_now to deliver_later, Active Job will automatically send this email asynchronously in the queue
    ReservationMailer.host_email(customer, host, listing).deliver_later
  end
  
end
