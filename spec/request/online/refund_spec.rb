RSpec.describe PxPay::Request::Online::Refund do
  it 'basic' do
    time = Time.now
    request = PxPay::Request::Online::Refund.new(
      order_id: '123',
      bank_transaction_id: '456',
      amount: 100,
      trade_time: time
    )
    req_time = request.send(:request_time)
    hash = request.send(:to_hash)
    expect(hash[:mer_trade_no]).to eq('123')
    expect(hash[:amount]).to eq(100)
    expect(hash[:px_trade_no]).to eq('456')
    expect(hash[:refund_mer_trade_no]).to eq('123')
    expect(hash[:trade_time]).to eq(time.strftime('%Y%m%d%H%M%S'))
    expect(request.send(:hash_string)).to eq("123456#{time.strftime('%Y%m%d%H%M%S')}123100#{req_time}")
  end
end
