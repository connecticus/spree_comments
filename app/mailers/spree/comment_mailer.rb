class Spree::CommentMailer < ActionMailer::Base
  default from: Spree::Config.mails_from

  def notify_email(comment)
    @comment = comment
    mail to: SpreeComments::Config.emails_to_notify,
      subject: Spree.t(:comment_email_subject, user_email: comment.user.email,
                                               type: comment.commentable_type.constantize.class_name,
                                               number: comment.commentable.number )
  end
end
