desc "Backend and frontend specs"
task test: :environment do
  system("bundle exec rspec") &&
    system("cd ngapp; grunt test; cd ..")
end
