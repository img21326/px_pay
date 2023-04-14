RSpec.describe PxPay do
  it 'basic' do
    secret_key = '541AA5BE3ABFC734785020541B0D83E4BB608B5E383FF3041E213C1AB647D518'
    mer_trade_no = 'QW20210101000032'
    device_type = '1'
    req_time = '20180301230111'
    plaintext = mer_trade_no + device_type + req_time

    should_be = '882c8ddc6e7ec3e23229ce00a2083f0faf10c0ca3eac67b31291ab95d2579d56'

    expect(PxPay::Utils.sign(plaintext, secret_key)).to eq(should_be)
  end
end
