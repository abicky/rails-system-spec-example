require 'rails_helper'

RSpec.describe "Root", type: :system do
  describe '/' do
    it 'displays "Hello"' do
      visit '/'
      expect(page).to have_content('Hello')
    end
  end
end
