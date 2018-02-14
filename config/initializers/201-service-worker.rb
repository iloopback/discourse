if SiteSetting.native_app_install_banner || DiscoursePluginRegistry.service_workers.present?
  require 'middleware/service_worker'
  Rails.configuration.middleware.unshift Middleware::ServiceWorker
end
