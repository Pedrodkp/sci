Rails.application.configure do
  config.cache_classes = false
  config.eager_load = true
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = true
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.assets.debug = true

  config.action_mailer.smtp_settings = {
    address: Rails.application.secrets.smtp_adress,
    port: 587,
    domain: Rails.application.secrets.domain_name,
    authentication: "plain",
    #enable_starttls_auto: true,
    openssl_verify_mode: 'none', 
    user_name: Rails.application.secrets.email_provider_username,
    password: Rails.application.secrets.email_provider_apikey,
    ssl: false
  }

  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.assets.digest = true
  config.assets.raise_runtime_errors = true
end
