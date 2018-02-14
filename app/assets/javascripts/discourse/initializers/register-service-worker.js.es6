export default {
  name: 'register-service-worker',

  initialize(container) {
    window.addEventListener('load', () => {
      const siteSettings = container.lookup('site-settings:main');

      const isSecured = (document.location.protocol === 'https:') ||
        (location.hostname === "localhost");

      const isSupported= isSecured && ('serviceWorker' in navigator);

      if (isSupported) {
        if (siteSettings.native_app_install_banner || Discourse.InstallServiceWorker) {
          navigator.serviceWorker
            .register(`${Discourse.BaseUri}/service-worker.js`)
            .catch(error => {
              Ember.Logger.info(`Failed to register Service Worker: ${error}`);
            });
        } else {
          navigator.serviceWorker.getRegistrations().then(registrations => {
            for(let registration of registrations) {
              registration.unregister();
            };
          });
        }
      }
    });
  }
};
