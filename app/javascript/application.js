import { Turbo } from "@hotwired/turbo-rails";

// rails-ujs はImportmapやESMモジュールとして読み込まず、Sprockets で管理
Rails.start();

// Stimulus コントローラーのインポートと登録
import { application } from "controllers/application";
import HelloController from "controllers/hello_controller";
application.register("hello", HelloController);

Turbo.session.drive = true;
