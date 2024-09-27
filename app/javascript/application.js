import "@hotwired/turbo-rails"; // 直接 Turbo をインポートしない
import Rails from "@rails/ujs";  // UJS をインポート

Rails.start();

// Stimulus コントローラーのインポートと登録
import { application } from "controllers/application";  
import HelloController from "controllers/hello_controller";
application.register("hello", HelloController);