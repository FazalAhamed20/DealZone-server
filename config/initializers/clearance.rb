Clearance.configure do |config|
  config.allow_sign_up = true
  config.cookie_domain = 'localhost'
  config.httponly = true
  config.rotate_csrf_on_sign_in = false
  config.cookie_expiration = lambda { |cookies| 1.year.from_now.utc }
end
