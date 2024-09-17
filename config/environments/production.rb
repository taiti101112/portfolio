require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true

  # セッションストアの設定
  config.session_store :cookie_store, key: '_tcg_place_session', secure: Rails.env.production?, same_site: :lax

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # CSRF保護を有効にする
  config.action_controller.allow_forgery_protection = true
  config.force_ssl = true

  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?


  # Compress CSS using a preprocessor.
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  config.active_storage.service = :local
  config.log_level = :info
  config.log_tags = [ :request_id ]
  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false
  config.log_formatter = ::Logger::Formatter.new

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false

  # メール設定
  config.action_mailer.default_url_options = { host: 'https://tcgplace-9f88c4df2f96.herokuapp.com' } # 本番環境のURL
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              'smtp.gmail.com',
    port:                 587,
    domain:               'herokuapp.com', # 使用するドメインを指定
    user_name:            ENV['MAILER_SENDER'],
    password:             ENV['MAILER_PASSWORD'],
    authentication:       'plain',
    enable_starttls_auto: true 
  }

end
