Rails.application.config.generators do |generators|
  generators.test_framework :rspec
  generators.fixture_replacement :factory_bot
  generators.factory_bot dir: 'spec/factories'
end
