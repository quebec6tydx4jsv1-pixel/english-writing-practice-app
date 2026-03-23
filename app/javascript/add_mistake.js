document.addEventListener("click", (e) => {
  if (e.target.classList.contains("add-mistake-btn")) {

    const expression = e.target.dataset.expression;
    const mistakeId = e.target.dataset.mistakeId;

    // hidden_field（配列）を取得
    const hiddenField = document.querySelector("#mistake_ids_field");

    // 既存の値を配列として取得
    let ids = hiddenField.value ? hiddenField.value.split(",") : [];

    // すでに追加済みならスキップ（重複防止）
    if (ids.includes(mistakeId)) return;

    // 新しい ID を追加å
    ids.push(mistakeId);
    hiddenField.value = ids.join(",");

    // 下のリストにカードを追加
    const list = document.querySelector("#selected_list");
    const item = document.createElement("div");
    item.className = "flex justify-between items-center border rounded p-2 bg-white shadow-sm";

    item.innerHTML = `
      <span class="bg-red-50 text-red-600 px-2 py-1 rounded">${expression}</span>
      <button class="remove-btn bg-red-500 text-white px-3 py-1 rounded shadow hover:bg-red-600 text-sm">
        削除
      </button>
    `;

    list.appendChild(item);

    // 削除ボタンの動作
    item.querySelector(".remove-btn").addEventListener("click", () => {
      item.remove();
      ids = ids.filter(id => id !== mistakeId);
      hiddenField.value = ids.join(",");
    });
  }
});

export {}