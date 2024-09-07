# config/initializers/session_store.rb
# 以下の記述があるとログインはできるがログアウトできない
# 以下の記述がないとログアウトはできるがログインができない
# Rails.application.config.session_store :cookie_store, key: '_tcg_place_session', secure: Rails.env.production?, same_site: :none, domain: :all, tld_length: 2
# Rails.application.config.session_store :cookie_store, key: '_tcg_place_session', secure: Rails.env.production?, same_site: nil

