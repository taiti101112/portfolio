import { Turbo } from "@hotwired/turbo-rails";

// rails-ujsを相対パスで読み込む
import Rails from "../node_modules/@rails/ujs";
Rails.start();

// Stimulus コントローラーのインポートと登録
import { application } from "controllers/application";  
import HelloController from "controllers/hello_controller";
application.register("hello", HelloController);

Turbo.session.drive = true;
