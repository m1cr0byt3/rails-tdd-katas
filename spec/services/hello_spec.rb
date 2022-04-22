require 'rails_helper'

RSpec.describe Hello, type: :service do
  describe 'hello' do
    it 'should be print hello' do
      greeting = 'Hello'
      expect(greeting).to be 'Hello'
    end
  end
end
