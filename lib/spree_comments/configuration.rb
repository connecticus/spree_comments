module SpreeComments
  class Configuration < Spree::Preferences::Configuration
    preference :notify_roles, :string, default: 'admin'

    def notification_methods
      ['email']
    end

    def emails_to_notify
      Spree.user_class
        .includes(:spree_roles)
        .where("spree_roles.name" => notify_roles.split)
        .pluck(:email)
    end
  end
end
