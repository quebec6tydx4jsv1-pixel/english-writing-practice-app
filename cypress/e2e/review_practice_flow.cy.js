describe("Review Practice Flow", () => {

  it("弱点一覧 → 反復練習 → 回答 → 添削結果", () => {

    // まずログイン
    cy.visit("/users/sign_in")
    cy.get("#user_email").type("test@example.com")
    cy.get("#user_password").type("password")
    cy.get("input[type='submit']").click()

    cy.contains("ログアウト")   // ← ログイン成功確認

    // 弱点一覧へ
    cy.visit("/user_weak_expressions")

    // 最初の弱点の「反復練習する」をクリック（安定版）
    cy.get(".weak-expression-item")
      .first()
      .find(".review-practice-link")
      .click()

    // 出題画面
    cy.contains("反復練習モード")
    cy.contains("英作文入力")

    // 回答
    cy.get("textarea[name='review_answer[review_answer_text]']")
      .type("I go shopping yesterday")
        cy.get("input[type='submit']").click()

    // 添削結果
    cy.contains("模範解答")
    cy.contains("あなたの解答")
    cy.contains("克服した表現")

    // 一覧へ戻る
    cy.contains("弱点一覧に戻る").click()
    cy.contains("苦手表現一覧")
  })
})
