describe("Learning Flow", () => {

  it("英作文 → 添削 → ログイン → 苦手表現登録", () => {

    cy.visit("/")

    cy.contains("英作文を始める").click()

    // テーマ入力
    cy.get("input[name='question[input_theme]']").type("日常会話")
    cy.get("textarea[name='question[input_situation]']").type("昨日の出来事")
    cy.get("input[type='submit']").click()

    // 出題
    cy.contains("昨日何をしましたか？")

    // 英作文入力
    cy.get("textarea[name='user_answer[answer_text]']")
      .type("I go shopping yesterday")

    cy.get("input[type='submit']").click()

    // 添削結果ページ
    cy.contains("模範解答")
    cy.contains("あなたの解答")

    // ログイン
    cy.contains("ログインへ進む").click()

    cy.url().should("include", "/users/sign_in")
    cy.get("#user_email").should("be.visible")

    cy.get("#user_email").type("test@example.com")
    cy.get("#user_password").type("password")

    cy.get("input[type='submit']").click()

    // 添削結果に戻る
    cy.contains("間違えた表現（選択ボタンを押すと下の登録欄に自動入力されます）")

    // Mistake候補をクリック
    cy.contains("button", "選択").first().scrollIntoView().click()
    // inputに自動入力される
    cy.get("#weak_expression_input")
      .should("not.have.value", "")

    // 登録
    cy.contains("登録＆苦手表現一覧へ").click()

    // 一覧ページ確認
    cy.contains("苦手表現一覧")

  })

})