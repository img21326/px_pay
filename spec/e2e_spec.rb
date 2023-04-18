require 'securerandom'
RSpec.describe PxPay do
  let!(:config) do
    config = PxPay::Config.new
    config.store_id = ENV['STORE_ID']
    config.store_name = 'S0006787'
    config.secret_key = ENV['SECRET_KEY']
    config
  end
  let(:ec_transaction_id) { 1 }

  it 'online_pay' do
    request = PxPay::Request::Online::Pay.new(
      transaction_id: ec_transaction_id,
      amount: 100,
      device_type: :pc,
      web_confirm_url: 'http://example.com/confirm',
      web_cancel_url: 'http://example.com/cancel'
    )
    request.config = config
    res = request.request
    p res
    expect(res.success?).to be(true)
  end
end
