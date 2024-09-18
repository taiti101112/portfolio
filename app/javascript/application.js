// app/javascript/application.js

import { Turbo } from "@hotwired/turbo-rails";
import Rails from "@rails/ujs";

// コントローラーの明示的なインポートと登録
import { application } from "controllers/application";  
import HelloController from "controllers/hello_controller";
application.register("hello", HelloController);  // HelloController を登録

Turbo.session.drive = true; // Turboの動作を有効にします
Rails.start();