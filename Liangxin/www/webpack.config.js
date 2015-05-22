var webpack = require('webpack');
var commonsPlugin =
  new webpack.optimize.CommonsChunkPlugin('common.js');


var entries = {};

[
    'groupdetail',
    'groupintro',
    'publish'
].forEach(function(key){
    entries[key] = __dirname + '/entries/' + key + '.js';
});

module.exports = {
    entry: entries,
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