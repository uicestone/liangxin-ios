var webpack = require('webpack');
var commonsPlugin =
  new webpack.optimize.CommonsChunkPlugin('common.js');

module.exports = {
    entry: {
        groupdetail: __dirname + '/entries/groupdetail.js',
        another: __dirname + '/entries/another.js'
    },
    output: {
        path: __dirname + '/build',
        filename: "[name].js",
        chunkFilename: "[id].bundle.js"
    },
    resolve: {
        root: __dirname,
        modulesDirectories: [__dirname, "node_modules", "mods", "views"],
    },
    module: {
        loaders: [
            { test: /\.ejs/, loader: "ejs-loader" }
        ]
    },
    plugins: [commonsPlugin, new webpack.ProvidePlugin({
        _: "underscore"
    })],
};