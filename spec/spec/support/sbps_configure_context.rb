shared_context "sbps_configure" do
  before do
    Sbps.configure do |config|
      config.merchant_id = "22255"
      config.service_id = "006"
      config.secret_key = "47f99cb253ec10d3d87ae409"
      config.initial_key = "fcc67421"
      config.hash_key = "47f99cb253ec10d3d87ae409fcc67421b1e7786e"
      config.basic_auth_id = "22255006"
      config.basic_auth_pass = "47f99cb253ec10d3d87ae409fcc67421b1e7786e"
    end
  end
end
