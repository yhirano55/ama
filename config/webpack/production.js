const environment = require('./environment')
const webpack = require('webpack')
const merge = require('webpack-merge')

const uglifyJsPlugin = environment.plugins.get('UglifyJs')
uglifyJsPlugin.options = merge(uglifyJsPlugin.options, { sourceMap: false })

const CSSLoader = environment.loaders.get('sass').use.find(el => el.loader === 'css-loader')
CSSLoader.options = merge(CSSLoader.options, { sourceMap: false })

// https://webpack.js.org/configuration/devtool/
// default is `nosources-source-map`
environment.devtool = null
module.exports = environment.toWebpackConfig()
