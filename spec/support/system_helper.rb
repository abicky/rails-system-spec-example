module SystemHelper
  extend ActiveSupport::Concern

  included do |example_group|
    # Screenshots are not taken correctly
    # because RSpec::Rails::SystemExampleGroup calls after_teardown before before_teardown
    example_group.after do
      take_failed_screenshot
    end
  end

  def display_console_logs
    console_logs.each do |log|
      t = log.timestamp
      message = log.message.sub(%r{http://127.0.0.1:\d+}, '')
      message.sub!(%r{\bapplication-\w+\.js\b}, 'application.js')
      puts "#{Time.at(t / 1000, t % 1000 * 1000).strftime('%F %H:%M:%S.%3N')}: #{log.level}: #{message}"
    end
    nil
  end

  def console_logs
    @console_logs ||= []
    @console_logs.concat(page.driver.browser.manage.logs.get(:browser))
  end

  def take_failed_screenshot
    return if @is_failed_screenshot_taken
    super
    @is_failed_screenshot_taken = true
  end
end
