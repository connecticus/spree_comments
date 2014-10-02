module SpreeComments
  class Configuration < Spree::Preferences::Configuration
    preference :notification_methods, :string
    preference :notify_roles, :string, default: 'admin'

    def notification_methods
      get(:notification_methods).split
    end

    def emails_to_notify
      Spree.user_class
        .includes(:spree_roles)
        .where("#{Spree::Role.table_name}.name" => notify_roles.split)
        .pluck(:email)
    end
  end
end
