RSpec.describe PxPay do
  it 'basic' do
    secret_key = '541AA5BE3ABFC734785020541B0D83E4BB608B5E383FF3041E213C1AB647D518'
    mer_trade_no = 'QW20210101000032'
    device_type = '1'
    req_time = '20180301230111'
    plaintext = [mer_trade_no, device_type, req_time].join

    should_be = '882C8DDC6E7EC3E23229CE00A2083F0FAF10C0CA3EAC67B31291AB95D2579D56'

    expect(PxPay::Utils.sign(plaintext, secret_key)).to eq(should_be)
  end
end
