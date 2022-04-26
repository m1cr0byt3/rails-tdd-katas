# frozen_string_literal: true

require 'rails_helper'
RSpec.describe(KataManager::Anagram, type: :service) do
  describe '#call' do
    let(:anagram) { KataManager::Anagram.call(Utils::WORD, Files::OK) }

    context 'when success' do

      it 'validate words' do
        expect(anagram.success?).to be(true)
      end
    end
  end
end
