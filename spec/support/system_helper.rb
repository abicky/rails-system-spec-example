module SystemHelper
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
end
