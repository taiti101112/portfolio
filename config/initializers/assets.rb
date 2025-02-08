Rails.application.config.assets.version = "1.0"

Rails.application.config.assets.precompile += %w( favicon.ico favicon-16x16.png favicon-32x32.png apple-touch-icon.png site.webmanifest )
Rails.application.config.assets.configure do |env|
  env.context_class.class_eval do
    def asset_path(path, options = {})
      super(path, options.merge(crossorigin: 'anonymous'))
    end
  end
end