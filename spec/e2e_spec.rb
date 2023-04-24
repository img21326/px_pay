require 'securerandom'
RSpec.describe PxPay do
  let!(:ec_config) do
    config = PxPay::Config.new
    config.store_id = ENV['STORE_ID']
    config.store_name = 'S0006787'
    config.secret_key = ENV['SECRET_KEY']
    config
  end

  let!(:pos_config) do
    config = PxPay::Config.new
    config.store_id = ENV['POS_STORE_ID']
    config.store_name = 'S0006786'
    config.secret_key = ENV['POS_SECRET_KEY']
    config
  end
  let(:ec_order_id) { 1 }
  let(:pos_order_id) { 2 }

  it 'online_pay' do
    request = PxPay::Request::Online::Pay.new(
      order_id: ec_order_id,
      amount: 100,
      device_type: :pc,
      web_confirm_url: 'http://example.com/confirm',
      web_cancel_url: 'http://example.com/cancel'
    )
    request.config = ec_config
    res = request.request
    p res
    expect(res.success?).to be(true)
  end

  it 'pos_pay' do
    request = PxPay::Request::Pos::Pay.new(
      store_id: 1,
      store_name: 'weiby_test',
      pos_id: 1,
      trade_time: Time.now,
      merchant_trade_number: pos_order_id,
      amount: 100,
      pay_token: 'P2A27194D27P53GR1I'
    )

    request.config = pos_config
    res = request.request
    p res
    expect(res.success?).to be(true)
  end
end
