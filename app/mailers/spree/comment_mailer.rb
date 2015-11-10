class Spree::CommentMailer < ActionMailer::Base
  def notify_email(comments, date)
    @comments = comments
    @date = date

    mail to: SpreeComments::Config.emails_to_notify, subject: Spree.t(
      :comment_email_subject,
      date: date.strftime("%Y-%m-%d"),
      count: comments.count
    )
  end
end
