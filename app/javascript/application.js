// Stimulus コントローラーのインポートと登録
import { application } from "controllers/application";
import HelloController from "controllers/hello_controller";
application.register("hello", HelloController);

// Importmapで管理されるので、ここでは @hotwired/turbo-rails や @rails/ujs を直接インポートしません
