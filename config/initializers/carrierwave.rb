#config/initializers/carrierwave.rb
CarrierWave.configure do |config|
	config.storage = :grid_fs
	config.grid_fs_access_url = "/upload/grid"
end