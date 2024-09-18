const path = require("path");
const webpack = require("webpack");
const ESLintPlugin = require('eslint-webpack-plugin');
const ReactRefreshWebpackPlugin = require('@pmmmwh/react-refresh-webpack-plugin');

module.exports = {
    entry: "./src/index.js",
    mode: "production",
    module: {
        rules: [
            {
                test: /\.(js|jsx)$/,
                exclude: /(node_modules|bower_components)/,
                loader: "babel-loader",
                options: {
                    presets: ["@babel/env"],
                    plugins: ['react-refresh/babel']
                }
            },
            {
                test: /\.css$/,
                use: ["style-loader", "css-loader"]
            }
        ]
    },
    resolve: { extensions: ["*", ".js", ".jsx"] },
    output: {
        path: path.resolve(__dirname, "dist/"),
        publicPath: "/dist/",
        filename: "bundle.js"
    },
    devtool: "source-map",
    devServer: {
        static: {
            directory: path.join(__dirname, "public/")
        },
        port: 3000,
        allowedHosts: [
            'todoweb',
            'todo.jobico.local'
        ],
        devMiddleware: {
            publicPath: "https://todo.jobico.local/dist/"
        },
        hot: false,
        liveReload: false
    },
    plugins: [new ReactRefreshWebpackPlugin(), new ESLintPlugin()]
};
