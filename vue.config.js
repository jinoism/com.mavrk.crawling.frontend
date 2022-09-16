const path = require('path')

module.exports = {
  //publicPath: process.env.NODE_ENV === 'production' ? 'file:///android_asset/' : '/',
  lintOnSave: false,
  'outputDir': './dist',
  'devServer': {
    'hot': true,
    'port': 7040,
    'open': false,
    'proxy': {
      '/api': {
        'target': process.env.VUE_APP_PROXY_TARGET,
        'changeOrigin': true,
        'pathRewrite': {
          '^/api': ''
        },
        'logLevel': 'debug',
        'secure': false
      }
    },
    'inline': true,
    // error display on the console
    'overlay': false
  },
  chainWebpack: config => {
    config.plugin('html').tap(args => {
      args[0].title = 'revex'
      return args
    })
    config.plugins.delete('prefetch')
    // Disable prefetch and preload of async modules for 'app' page
    config.plugins.store.delete('prefetch-app')
    config.plugins.store.delete('preload-app')
    // Use this syntax if not using multipage setup
    config.plugins.store.delete('prefetch')
    config.plugins.store.delete('preload')

    // config.output.chunkFilename('[id].[chunkhash:8].js')
    // config.entry('index').add('babel-polyfill')
  },
  configureWebpack: {

    module: {
      rules: [
        {
          test: /\.js$/,
          exclude: /node_modules/,
          use: 'babel-loader'
        }
      ]
    },
    resolve: {
      alias: {
        '@': path.resolve(__dirname, 'src')
      }
    },
    performance: {
      hints: false
    },
    optimization: {
      splitChunks: {
        chunks: 'async',
        minSize: 30000,
        maxSize: 0,
        minChunks: 1,
        maxAsyncRequests: 5,
        maxInitialRequests: 3,
        automaticNameDelimiter: '~',
        name: true,
        cacheGroups: {
          vendors: {
            test: /[\\/]node_modules[\\/]/, // this is what you are looking for
            priority: -10
          },
          default: {
            minChunks: 2,
            priority: -20,
            reuseExistingChunk: true
          }
        }
      }
    },
    plugins: []
  },
  transpileDependencies: []
}
