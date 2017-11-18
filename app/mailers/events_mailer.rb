class EventsMailer < ApplicationMailer
  def notify_event_reminder_user(event, user)
    @event = event
    @user = user
    mail(to: @user.email, subject: "You have an upcoming #{@event.event_type}!")
  end

  def notify_event_reminder_guest(event, guest)
    @event = event
    @guest = guest
    mail(to: @guest.email, subject: "You have an upcoming #{@event.event_type}!")
  end

  def notify_signup_user(event, user)
    @event = event
    @user = user
    mail(to: @user.email, subject: "You have signed up for an #{@event.event_type}!")
  end

  def notify_signup_guest(event, guest)
    @event = event
    @guest = guest
    mail(to: @guest.email, subject: "You have signed up for an #{@event.event_type}!")
  end

  def notify_event_destroy_user(event, user)
    @event = event
    @user = user
    mail(to: @user.email, subject: "Your event, #{@event.name} has been canceled.")
  end

  def notify_event_destroy_guest(event, guest)
    @event = event
    @guest = guest
    mail(to: @guest.email, subject: "Your event, #{@event.name} has been canceled.")
  end
end
