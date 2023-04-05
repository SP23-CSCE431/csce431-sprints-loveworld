require "active_support/core_ext/integer/time"

# The test environment is used exclusively to run your application's
# test suite. You never need to work with it otherwise. Remember that
# your test database is "scratch space" for the test suite and is wiped
# and recreated between test runs. Don't rely on the data there!

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Turn false under Spring and add config.action_view.cache_template_loading = true.
  config.cache_classes = true

  # Eager loading loads your whole application. When running a single test locally,
  # this probably isn't necessary. It's a good idea to do in a continuous integration
  # system, or in some way before deploying your code.
  config.eager_load = ENV["CI"].present?

  # Configure public file server for tests with Cache-Control for performance.
  config.public_file_server.enabled = true
  config.public_file_server.headers = {
    "Cache-Control" => "public, max-age=#{1.hour.to_i}"
  }

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.cache_store = :null_store

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Store uploaded files on the local file system in a temporary directory.
  config.active_storage.service = :test

  config.action_mailer.perform_caching = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true


  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
    :provider => "google_oauth2",
    :uid => "123456789",
    :info => {
      :name => "Tony Stark",
      :email => "tony@stark.com"
    }
  })


  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true
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
end