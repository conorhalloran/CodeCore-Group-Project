class EventsMailer < ApplicationMailer
  def notify_event_guest(event)
    @event = event
    @user = @event.user
    mail(to: @user.email, subject: "You have a pending #{@event.event_type}!")
  end
end
