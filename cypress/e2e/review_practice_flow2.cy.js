describe("Review Practice Flow (Spec-level)", () => {
  it("弱点一覧 → 出題生成 → 回答 → 添削 → 一覧へ戻る", () => {
    let weakExpression = ""

    // --- ログイン ---
    cy.visit("/users/sign_in")
    cy.get("#user_email").type("test@example.com")
    cy.get("#user_password").type("password")
    cy.get("input[type='submit']").click()
    cy.contains("ログアウト")

    // --- 弱点一覧 ---
    cy.visit("/user_weak_expressions")

    // 最初の弱点を取得 & テキストを変数に保存
    cy.get(".weak-expression-item")
      .first()
      .as("firstWeak")

    cy.get("@firstWeak")
      .find("p")
      .invoke("text")
      .then((text) => {
        weakExpression = text.trim()
      })

    // --- 反復練習モードへ ---
    cy.get("@firstWeak")
      .find(".review-practice-link")
      .click()

    // 出題画面
    cy.contains("反復練習モード")
    cy.contains("英作文入力")

    // 出題文が弱点の表現を含むことを確認
    cy.then(() => {
      cy.contains(`次の表現を使って英作文してください: ${weakExpression}`)
    })

    // --- 回答 ---
    cy.get("textarea[name='review_answer[review_answer_text]']", { timeout: 5000 })
      .should("be.visible")
      .type("I go shopping yesterday")

    cy.get("input[type='submit']").click()

    // --- 添削結果 ---
    cy.contains("反復練習添削結果")
    cy.contains("模範解答")
    cy.contains("あなたの解答")
    cy.contains("克服した表現")

    // 克服した表現が元の弱点と一致すること
    cy.then(() => {
      cy.contains(weakExpression)
    })

    // --- 一覧へ戻る ---
    cy.contains("弱点一覧に戻る").click()
    cy.contains("苦手表現一覧")
  })
})
