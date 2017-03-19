require 'helpers/mail_chimp_subscription'

class SubscribeUserToMailingListJob < ApplicationJob
  queue_as :default

  def perform(email)
    # Do something later
  end
end
