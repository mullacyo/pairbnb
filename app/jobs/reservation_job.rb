class ReservationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    ReservationMailer.booking_email(*args).deliver_now
    # Do something later
  end
end
