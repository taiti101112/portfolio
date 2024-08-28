// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// app/javascript/application.js

// Importmapを使ってピン留めされたモジュールをインポート
import "@hotwired/turbo-rails";
import { Application } from "@hotwired/stimulus";

// Stimulusの設定
const application = Application.start();
