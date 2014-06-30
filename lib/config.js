/////////// config for require.js

(function() {

  require.config({
    baseUrl: '../',
    paths: {
      'cdn.jquery': "lib/jquery",
      'cdn.underscore': "lib/underscore",
      'vs-sticky': "src/vs-sticky"
    },
    shim: {
      'cdn.jquery': {
        exports: '$'
      },
      'cdn.underscore': {
        exports: '_'
      }
    }
  });

}).call(this);
