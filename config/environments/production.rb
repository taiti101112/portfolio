# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

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

  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  config.assets.compile = false

  config.active_storage.service = :local
  config.log_level = :info
  config.log_tags = [:request_id]
  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false
  config.log_formatter = Logger::Formatter.new

  if ENV['RAILS_LOG_TO_STDOUT'].present?
    logger           = ActiveSupport::Logger.new($stdout)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false

  # メール設定
  config.action_mailer.default_url_options = { host: 'www.tcg-place.com', protocol: 'https' }
  config.action_mailer.default_options = { from: ENV['MAILER_SENDER'] || 'no-reply@tcg-place.com' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: ENV.fetch('SMTP_ADDRESS', nil),
    port: ENV['SMTP_PORT'].to_i,
    domain: ENV.fetch('SMTP_DOMAIN', nil),
    user_name: ENV.fetch('SMTP_USER_NAME', nil),
    password: ENV.fetch('SMTP_PASSWORD', nil),
    authentication: ENV['SMTP_AUTHENTICATION'].to_sym,
    enable_starttls_auto: ENV['SMTP_ENABLE_STARTTLS_AUTO'] == 'true'
  }
end
