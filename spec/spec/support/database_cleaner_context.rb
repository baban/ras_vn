# encoding: utf-8
shared_context "database_cleaner" do
  after(:all) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
    DatabaseCleaner.clean
  end
end
