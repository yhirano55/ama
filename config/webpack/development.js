const environment = require('./environment')
const eslintConfig = require('./loaders/eslint')
environment.loaders.append('eslint', eslintConfig)

module.exports = environment.toWebpackConfig()
