RSpec.describe PxPay::Response::Pos::Refund do
  it 'basic' do
    json_string = '{"mer_trade_no":"202101230000002", "gate_trade_no": null, "px_trade_no":"PXO023892398240", "status_code":"0000", "status_message":"交易成功", "amount": 300, "trade_amount": 277, "discount_amount": 10, "px_trade_time": "20210710143259", "invo_carrier":"/NFVIAZP", "marketing":[ { "marketing_code": "aaaaaabbbbbbcccccc", "discount": 10 }, { "marketing_code": "ffffff777777dddddd", "discount": 3 } ] }'
    json_data = JSON.parse(json_string)
    res = PxPay::Response::Pos::Refund.new(json_data, nil)
    expect(res.success?).to be true
    expect(res.message).to eq('交易成功')
    expect(res.transaction_id).to eq('202101230000002')
    expect(res.trade_time).to eq(Time.parse('20210710143259'))
    expect(res.amount).to eq(300)
    expect(res.discount_amount).to eq(10)
    expect(res.invo_carrier).to eq('/NFVIAZP')
  end
end
