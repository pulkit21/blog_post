if Rails.env.development?
  BetterErrors::Middleware.allow_ip! ENV['TRUSTED_IP'] if ENV['TRUSTED_IP']
  BetterErrors.editor = :sublime if defined? BetterErrors
end
