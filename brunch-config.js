/*eslint-env node */

module.exports = {
  config: {
    paths: {
      watched: ["src", "src/elm"]
    },
    server: {
      port: 3000
    },
    files: {
      javascripts: {
        joinTo: "app.js"
      },
      stylesheets: {
        joinTo: "app.css"
      }
    },
    plugins: {
      elmBrunch: {
        mainModules: ["src/elm/Main.elm"],
        outputFolder: "public/"
      },
      sass: {
            options: {
              includePaths: [
                'node_modules/foundation-sites/scss',
                'src/sass'
              ]
            }
      }
    }
  }
};
