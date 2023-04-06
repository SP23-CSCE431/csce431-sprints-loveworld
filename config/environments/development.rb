require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded any time
  # it changes. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable server timing
  config.server_timing = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Uncomment if you wish to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true
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
  ENV['ADMIN_EMAILS']="rmccauley01@tamu.edu"
end
