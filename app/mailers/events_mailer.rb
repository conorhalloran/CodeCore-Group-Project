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

  def leader_notify_user(event, user, message)
    @event = event
    @user = user
    @message = message
    mail(to: @user.email, subject: "There has been an update to your #{@event.event_type}")
  end

  def leader_notify_guest(event, message)
    @event = event
    # @guest = guest
    @message = message
    mail(to: 'dkim.steve@gmail.com', subject: "There has been an update to your")
  end


end
