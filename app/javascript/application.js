import { Turbo } from "@hotwired/turbo-rails";

// @rails/ujs をローカルからインポート
import * as Rails from "rails-ujs";
Rails.start();

// Stimulus コントローラーのインポートと登録
import { application } from "controllers/application";  
import HelloController from "controllers/hello_controller";
application.register("hello", HelloController);

Turbo.session.drive = true;
