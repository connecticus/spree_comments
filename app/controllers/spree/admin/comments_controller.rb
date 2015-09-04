class Spree::Admin::CommentsController < Spree::Admin::ResourceController
  def location_after_save
    :back
  end
end
