const webpack = require('webpack');
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin')

const parentDir = path.join(__dirname, '../');

module.exports = {
  mode: "production",
  entry: [
    path.join(parentDir, 'src', 'index.js')
  ],
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        loader: 'babel-loader'
      },
      {
        test: /\.less$/,
        loaders: ["style-loader", "css-loader", "less-loader"]
      },
      {
        test: /\.css/,
        loaders: ["style-loader", "css-loader"]
      }
    ]
  },
  output: {
    path: parentDir + '/dist',
    filename: 'bundle.js'
  },
  plugins: [
    new HtmlWebpackPlugin({
      title: 'URL Shortener App',
      filename: path.join(parentDir, 'dist', 'index.html'),
      template: path.join(parentDir, 'src', 'assets', 'index.html'),
    })
  ],
  resolve: {
    alias: {
      config$: path.join(parentDir, 'src', 'config.js')
    }
  },
  devServer: {
    contentBase: parentDir,
    historyApiFallback: true
  }
}
