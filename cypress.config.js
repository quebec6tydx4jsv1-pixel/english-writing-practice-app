const { defineConfig } = require("cypress");

module.exports = defineConfig({
  allowCypressEnv: false,

  e2e: {
    baseUrl: "http://localhost:3000", // Cypress でテストを実行する際のベースURLを指定。これにより、テスト内で相対パスを使用してアプリケーションのページにアクセスできるように

    setupNodeEvents(on, config) {
      // implement node event listeners here
    },
  },
});
