class EventsMailer < ApplicationMailer
  def notify_event_guest(user)
    @user = user
    mail(to: @user.email, subject: 'You have a pending event!')
  end
end
