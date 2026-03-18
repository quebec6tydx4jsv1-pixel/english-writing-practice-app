document.addEventListener("click", (e) => {
  if (e.target.classList.contains("add-mistake-btn")) {

    const expression = e.target.dataset.expression;
    const mistakeId = e.target.dataset.mistakeId;

    const input = document.querySelector("#weak_expression_input");
    const hiddenMistakeId = document.querySelector("#mistake_id_field");

    if (input) input.value = expression;
    if (hiddenMistakeId) hiddenMistakeId.value = mistakeId;
  }
});
