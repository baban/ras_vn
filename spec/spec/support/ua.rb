Capybara.register_driver :mobile do |app|
  Capybara::RackTest::Driver.new(app, :headers => {'HTTP_USER_AGENT' => 'KDDI-CA39 UP.Browser/6.2.0.13.1.5 (GUI) MMP/2.0'})
end

Capybara.register_driver :sp do |app|
  Capybara::RackTest::Driver.new(app, :headers => {'HTTP_USER_AGENT' => 'Mozilla/5.0 (iPhone; CPU iPhone OS 5_0_1 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Mobile/9A405 Safari/7534.48.3'})
end
