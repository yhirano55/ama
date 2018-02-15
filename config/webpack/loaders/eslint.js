module.exports = {
  test: /\.js$/,
  loader: 'eslint-loader',
  enforce: 'pre',
  options: {
    formatter: require('eslint-friendly-formatter')
  }
}
