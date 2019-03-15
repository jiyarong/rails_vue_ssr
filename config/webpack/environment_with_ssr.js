const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())

environment.loaders.prepend('vue', vue);

module.exports = {
  toWebpackConfig () {
    return [webpackConfig, webpackConfigForServer]
  }
}

let webpackConfig = environment.toWebpackConfig();
let webpackConfigForServer = Object.assign({}, webpackConfig);
let _entry = Object.assign({}, webpackConfig.entry);
webpackConfig.entry = {};

Object.keys(_entry).forEach((entry_key) => {
  if (entry_key === "vue_server_render") {
    let _module = Object.assign({}, webpackConfig.module);
    _module.rules = Object.assign([], webpackConfig.module.rules);
    _module.rules.unshift({
      test: /\.(c|sa|sc)ss$/,
      loader: 'null-loader'
    });
    webpackConfigForServer.module = _module;
    webpackConfigForServer.entry = {};
    webpackConfigForServer.entry[entry_key] = _entry[entry_key];
    webpackConfigForServer.devServer = {}
  } else {
    webpackConfig.entry[entry_key] = _entry[entry_key];
  }
});
