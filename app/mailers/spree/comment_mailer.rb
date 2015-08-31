class Spree::CommentMailer < ActionMailer::Base
  default from: ENV['EMAIL_FROM'] || 'changeme@example.com'

  def notify_email(comments, date, tenant)
    @comments = comments
    @date = date
    @tenant = tenant

    mail to: SpreeComments::Config.emails_to_notify, subject: Spree.t(
      :comment_email_subject,
      tenant: tenant,
      date: date.strftime("%Y-%m-%d"),
      count: comments.count
    )
  end
end
