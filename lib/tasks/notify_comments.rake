namespace :notify_comments do
  desc "Sends a digest with comments made during the day"
  task nightly: :environment do
    today = Date.today
    date_start = today.beginning_of_day
    date_end = today.end_of_day

    puts "===> Start sending admin notification about comments left on #{today.strftime "%Y-%m-%d"}"

    Tenant::Utils.each_tenant do |tenant|
      puts "===> Working on #{tenant} comments"
      comments = Spree::Comment.where(created_at: date_start...date_end).to_a

      if comments.any?
        puts "===> Found #{comments.count} for #{tenant} tenant, sending email"
        Spree::CommentMailer.notify_email(comments, today, tenant).deliver
      else
        puts "===> No new comments found for #{tenant} tenant"
      end
    end

    puts "\nDone."
  end
end
