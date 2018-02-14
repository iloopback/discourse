class Middleware::ServiceWorker
  def initialize(app, settings = {})
    @app = app
  end

  def call(env)
    if env['REQUEST_METHOD'] == 'GET' && env['PATH_INFO'] == "#{Discourse.base_uri}/service-worker.js"
      return [
        200,
        { 'Content-Type' => 'application/javascript' },
        Rails.application.assets_manifest.find_sources('sw.js')
      ]
    end

    @app.call(env)
  end
end
