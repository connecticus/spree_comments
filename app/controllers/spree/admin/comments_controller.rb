class Spree::Admin::CommentsController < Spree::Admin::ResourceController
  create.after :notify

  private

  def notify
    SpreeComments::Notification.new(@comment).notify
  end

  def location_after_save
    :back
  end
end
