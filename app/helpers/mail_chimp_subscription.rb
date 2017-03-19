require 'mailchimp'

module MailChimpSubscription
	MAIL_CHIMP_API_KEY = ENV["MAIL_CHIMP_API_KEY"]
	MAIL_CHIMP_LIST_ID = ENV["MAIL_CHIMP_LIST_ID"]
	extend self

	def subscribe(email)
		mail_chimp.lists.subscribe(MAIL_CHIMP_LIST_ID, {email: email})

		rescue MailChimp::ListAlreadySubscribedError
			# decide what to do
		rescue Mailchimp::ListDoesNotExistError => e
			# this is an important error
			raise e
		rescue Mailchimp::Error => e
			# something that I don't know about
	end

	private
	def mail_chimp
		@mail_chimp ||= MailChimp::API.new(MAIL_CHIMP_API_KEY)
	end
end
