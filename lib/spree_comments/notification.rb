module SpreeComments
  class Notification

    attr_accessor :comment

    def initialize(comment)
      @comment = comment
    end

    def notify
      SpreeComments::Config.notification_methods.each do |notification_method|
        send("#{notification_method}_notify")
      end
    end

    private

    def email_notify
      Spree::CommentMailer.notify_email(@comment).deliver
    end
  end
end
