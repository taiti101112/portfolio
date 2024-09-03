# config/initializers/session_store.rb
Rails.application.config.session_store :cookie_store, key: '_tcg_place_session', secure: Rails.env.production?, same_site: :lax, domain: :all, tld_length: 2
