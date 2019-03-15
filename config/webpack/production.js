process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const environment = require('./environment_with_ssr')

module.exports = environment.toWebpackConfig()
