# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile += %w( favicon.ico favicon-16x16.png favicon-32x32.png apple-touch-icon.png site.webmanifest )
Rails.application.config.assets.configure do |env|
  env.context_class.class_eval do
    def asset_path(path, options = {})
      super(path, options.merge(crossorigin: 'anonymous'))
    end
  end
end