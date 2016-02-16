namespace :vl do
  desc "Creating default attributes plus default user"
  task setup: :environment do
    require Rails.root.join('db','seeds.rb')
  end

end
