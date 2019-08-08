# frozen_string_literal: true

group :puma do
  guard 'rack', host: '0.0.0.0' do
    watch(%r{^(?!spec/).*\.rb$})
  end
end

group :test do
  guard 'rspec', cmd: 'bundle exec rspec' do
    # Re-run every test every time a rb file changes.
    watch(/\.rb$/) { 'spec' }
  end
end
