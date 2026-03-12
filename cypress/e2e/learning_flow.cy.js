describe("Learning Flow", () => {

  it("英作文 → 添削", () => {

    // ① トップページ
    cy.visit("/")

    // ② テーマ入力
    cy.get("input[name='question[theme]']").type("日常会話")
    cy.get("input[name='question[situation]']").type("昨日の出来事")
    cy.contains("入力").click()

    // ③ 出題
    cy.contains("昨日何をしましたか？", { timeout: 10000 })

    // ④ 英作文入力
    cy.get("textarea[name='answer_text']")
      .type("I go shopping yesterday")

    cy.contains("入力").click()

    // ⑤ 添削結果
    cy.contains("模範解答", { timeout: 10000 })
    cy.contains("あなたの回答")

    // ⑥ 保存にはログイン
    cy.contains("サインイン")

  })

})