// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "./add_mistake"

// ローディングオーバーレイ
document.addEventListener("submit", function(e) {
  const submit = e.target.querySelector("[data-loading-submit]");
  if (!submit) return;
  const overlay = document.getElementById("loading-overlay");
  if (overlay) overlay.classList.remove("hidden");
});
