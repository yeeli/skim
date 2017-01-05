require "sprockets"

if Sprockets.respond_to?(:register_engine)
  args = ['.skim', Skim::Template]
  if Sprockets::VERSION.start_with? '3'
    args << {silence_deprecation: true, mime_type: 'text/skim'}
  end

  Sprockets.register_engine *args
else
  Sprockets.register_mime_type 'text/skim', extensions: ['.skim', '.jst.skim']
  Sprockets.register_transformer 'text/skim', 'application/javascript', Skim::Template
end

unless defined?(Rails::Engine)
  Sprockets.append_path File.expand_path('../../../vendor/assets/javascripts', __FILE__)
end
