Before do
  TestUtils.reset_fixture_cache
  fixtures_folder = File.join(Rails.root, 'test', 'fixtures')
  fixtures = Dir[File.join(fixtures_folder, '*.yml')].map do |f|
    File.basename(f, '.yml')
  end
  TestUtils.create_fixtures(fixtures_folder, fixtures)
end

