require 'spec_helper'

describe SpreeComments::Notification do
  describe '#notify' do

    before do
      Spree::CommentMailer.stub_chain(:notify_email, :deliver)
    end

    context 'when notification methods includes' do
      context 'email' do
        it 'sends an email to users defined in roles' do
          SpreeComments::Config.notification_methods = 'email'
          SpreeComments::Notification.new(create(:comment)).notify
          expect(Spree::CommentMailer).to have_received(:notify_email)
        end
      end
    end

    context 'when notification methods does not includes' do
      context 'email' do
        it 'does not send an email to users defined in roles' do
          SpreeComments::Config.notification_methods = nil
          SpreeComments::Notification.new(create(:comment)).notify
          expect(Spree::CommentMailer).not_to have_received(:notify_email)
        end
      end
    end
  end
end
