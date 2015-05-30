watchman -- trigger $PWD/Liangxin/www assets '*.*' -X 'node_modules' -- $PWD/copy-assets.sh
webpack --watch --config Liangxin/www/webpack.config.js