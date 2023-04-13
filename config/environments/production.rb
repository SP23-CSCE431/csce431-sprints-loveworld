require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Ensures that a master key has been made available in either ENV["RAILS_MASTER_KEY"]
  # or in config/master.key. This key is used to decrypt credentials (and other encrypted files).
  # config.require_master_key = true

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?

  # Compress CSS using a preprocessor.
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.asset_host = "http://assets.example.com"

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for Apache
  # config.action_dispatch.x_sendfile_header = "X-Accel-Redirect" # for NGINX

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Mount Action Cable outside main process or domain.
  # config.action_cable.mount_path = nil
  # config.action_cable.url = "wss://example.com/cable"
  # config.action_cable.allowed_request_origins = [ "http://example.com", /http:\/\/example.*/ ]

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # Include generic and useful information about system operation, but avoid logging too much
  # information to avoid inadvertent exposure of personally identifiable information (PII).
  config.log_level = :info

  # Prepend all log lines with the following tags.
  config.log_tags = [ :request_id ]

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Use a real queuing backend for Active Job (and separate queues per environment).
  # config.active_job.queue_adapter     = :resque
  # config.active_job.queue_name_prefix = "LoveWorld_production"

  config.action_mailer.perform_caching = false

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Don't log any deprecations.
  config.active_support.report_deprecations = false

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Use a different logger for distributed setups.
  # require "syslog/logger"
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new "app-name")

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false
  
  # google oauth info
  ENV['GOOGLE_OAUTH_CLIENT_ID'] = '783903801837-jkpimg3cddph2kikc6ip4uuhcue56e2l.apps.googleusercontent.com'
  ENV['GOOGLE_OAUTH_CLIENT_SECRET'] = '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'
  
  ENV['GOOGLE_CALENDAR_ID'] = 'c_6fa3a48d19f0d7d599da305fe3e3b26ca3ed3102a85a870552b0f4dbf80c0c07@group.calendar.google.com'
  ENV['GOOGLE_CALENDAR_URL'] = 'https://calendar.google.com/calendar/embed?src=c_6fa3a48d19f0d7d599da305fe3e3b26ca3ed3102a85a870552b0f4dbf80c0c07%40group.calendar.google.com&ctz=America%2FChicago'
  
  ENV['GOOGLE_SERVICE_ACCOUNT_JSON'] = '{
    "type": "service_account",
    "project_id": "blissful-star-380717",
    "private_key_id": "5a4e0d594a9512a8f0f25b20fe7bff2837a0dd64",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCyICUbEEv1RAag\nlACEQg8IF7KuKDipvyF7YIFMb68B9JYZNRUlie4x9AFUVYcouHqIRd8dMgcnE1m3\nBWf8mAr37PzPWrhcifLQTfKnYe/Jz97VWdjfP4dHcLrrCFasqrEs0gotAnjDxgWP\n4OtZx3b0tZ1GscvlOm4XMs2rG7J+KaxM6WkPCyQon64rgaVEnurxcQrQGwI2p2jd\nh73c3BpLKj72t7HoSCWvrD4LjB2pJthBJEzlj9Q5uOF99wbV4e1S2TLwH2Y3sAkM\njFen/YJu2bBFcZwY3CnQqV8Wf62rVmCxe5jhKe75XiCCnsVHnmxJ77e4ceXguhGb\nQVxFIDj7AgMBAAECggEAAWrzWtbh0nBOLHip1MDBH7Fdr6EvDelfufDxyuIjmNPX\njUcVnOn39QYxcZtO2bvxE42wo0zaF+eHV9LcdwbGyEzyadNfkzLN5CUar1ZhfsRz\n45od1oSyv39eBjtu8NCHW8NslgmsRX5IAQ1ZzGQ69IXbXECCCJgkdxeIPtGvQRxa\nOGiaCsHWo3cjTssn13A7BD3H1jaQCnfzfMezYSICZ0/G6SL7GVSM5ZouSaVpk9yG\n/FY1o0hXyAcjv+q5PXgHMfrfd6zb3zdmRVLfDC50e8BytpYvXtX+XVOUmRPz+Je4\nqNTP7ICht3g/Xg37xvtvXpWE/Zpy/DSJBTFffGJooQKBgQDdzdntNZNS8fSTbm/F\nM5XY3k1A+LzFv4IY17ph/olyRDkas/CWVB4A+NYEgz83/k3Cj51aH0a44BTc7WWY\nNFJaARYS3qyHLsVstbyeCTQuYLjt1hFskVAQSkjXlxkYCxiJiR0nmKzKF649zv4j\n4gFiMU111CorPBoeOqNg1k5BswKBgQDNlmRjRN66WwFd9k5rEAS+JU7v8ge8t8CB\nL7FDMFtzLe+a2EptbZxspczo3U4Ux7T6JMK+pV6JAovyHG0sJlY7Vb59Iicos50N\n113GZhocoZ0YkbwGKUagD18jgUWXDbLrf6CMTJalO7zFG4qsWCtd36A8QSzwZSZx\nafjAqQy3mQKBgQCWo94kasSaCtYO42xpxHU7Cw/w1n5u13gmIy3krBjxUEBwUFFP\n5+VQx6+i9PiUsNRjFWLK+H7xxM6mlVzwmGht1FsHidAnJ67R/EQUGTAlZ29xqHfB\nApgb2DfMpERYvgB2OHdikyCXSKoANHsKJ87Ev7NaGTRilLkwWqbnd+VCXQKBgHBt\nAOLkY6SnZbz7l/CmZuGQx3Uh9yc1mVlMOnTSuf/nq/MSusjSu0sS9FaXxz5H4+kz\nNyhIiMUGFn/FGdKd+GQkRLJrfdydNJLAJrD7XuYvXxhzgc4gvlWDcnSZGfQ78o8k\nUSjILU2YuGdV42TSJo0EYLzyq1+fAQHegMDi8WhpAoGAVJLUZIahPB0qEvmqjj4Y\nFyqHkICympf8pCFZVPWSVeLiZ4wmG3sm4BNk1EJnUMoShTcaFFeUJAfjObel8PA1\nxCO0coqubaH03HTiwzhLCzCyoUSQ2IkA7hSzTSAa/RKt+04t44i766S9qeLyfEAQ\nmffqVzkgDYsPVKay19soQMc=\n-----END PRIVATE KEY-----\n",
    "client_email": "calendar-bot@blissful-star-380717.iam.gserviceaccount.com",
    "client_id": "117302561422869932705",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/calendar-bot%40blissful-star-380717.iam.gserviceaccount.com"
  }'

  # admin info
  ENV['ADMIN_EMAILS']="nperk11@gmail.com"
end
