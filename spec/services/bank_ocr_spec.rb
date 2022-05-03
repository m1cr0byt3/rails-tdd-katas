# frozen_string_literal: true

require 'rails_helper'
RSpec.describe('KataManager::BankOcrChecksum', type: :service) do
  describe '#call' do
    let(:accounts) { Utils::ACCOUNTS }
    let(:accounts_fail) { Utils::ACCOUNTS_FAIL }
    let(:checksum) { KataManager::BankOcrChecksum.call(accounts) }
    let(:checksum_failed) { KataManager::BankOcrChecksum.call(accounts_fail) }
    
    context 'when success' do
      it 'validate correct checksum' do
        expect(checksum.success?).to be(true)
      end

      it 'validate total account numbers' do
        expect(accounts.length).to be(Utils::TOTAL_ACCOUNTS)
      end

      it 'valid array' do
        expect(accounts).to be_an(Array)
      end
    end

    context 'when fail' do
      it 'validate correct checksum' do
        expect(checksum_failed.success?).to be(false)
      end
    end
  end
end
