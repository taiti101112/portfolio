// app/javascript/application.js

import { Turbo } from "@hotwired/turbo-rails";
import Rails from "@rails/ujs";

// 変更箇所: 相対パスで各コントローラーを明示的にインポート
import "./controllers/application";
import "./controllers/hello_controller";

Turbo.session.drive = true; // Turboの動作を有効にします
Rails.start();
