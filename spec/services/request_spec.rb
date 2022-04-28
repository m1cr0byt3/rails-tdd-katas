# frozen_string_literal: true

require 'rails_helper'
RSpec.describe(HttpManager::Request, type: :service) do
  describe '#get' do
    let(:url_success) { 'https://github.com/falconmasters/expresiones-regulares/blob/master/Expresiones_Regulares.txt#L14' }
    let(:url_failed) { 'https://github.com/falconmasters/expresiones-regulares/blob/master/Expresiones_Regulares.json' }
    let(:http) { HttpManager::Request.new(url_success) }
    let(:http_failed) { HttpManager::Request.new(url_failed) }
    let(:service_get) { http.get }

    context 'when success' do
      it 'response 200' do
        expect(service_get).to be(true)
      end
    end

    context 'when fail' do
      it 'response 404' do
        expect(http_failed.get).to be(false)
      end
    end
  end
end
