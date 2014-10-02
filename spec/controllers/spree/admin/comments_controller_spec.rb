require 'spec_helper'

describe Spree::Admin::CommentsController do

  describe 'POST create' do

    stub_authorization!

    let(:notification) { SpreeComments::Notification.new(create(:comment)) }

    before do
      allow(notification).to receive(:notify)
      allow(SpreeComments::Notification).to receive(:new).and_return(notification)
      request.env["HTTP_REFERER"] = '/'
    end

    context 'when comment is created' do
      context 'and comment is saved' do
        it 'sends notifications' do
          spree_post :create, comment: attributes_for(:comment)
          expect(notification).to have_received(:notify)
        end
      end

      context 'and comment is not saved' do
        it 'does not send comment notification email' do
          Spree::Comment.any_instance.stub(:save).and_return(false)
          expect(notification).not_to have_received(:notify)
        end
      end
    end
  end
end
