console.log("mistake_fill loaded");
document.addEventListener("DOMContentLoaded", () => {

  const buttons = document.querySelectorAll(".add-mistake-btn")
  const input = document.getElementById("weak_expression_input")

  if (!input) return

  buttons.forEach(button => {

    button.addEventListener("click", () => {

      const expression = button.dataset.expression
      input.value = expression

    })

  })

})