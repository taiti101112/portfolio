import { Turbo } from "@hotwired/turbo-rails";
import Rails from "@rails/ujs";  // ここでローカルのUJSをインポート

Rails.start();

// Stimulus コントローラーのインポートと登録
import { application } from "controllers/application";  
import HelloController from "controllers/hello_controller";
application.register("hello", HelloController);

Turbo.session.drive = true;
