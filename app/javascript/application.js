// app/javascript/application.js

import { Turbo } from "@hotwired/turbo-rails";
import Rails from "@rails/ujs";
import "controllers";

Turbo.session.drive = true; // Turboの動作を有効にします
Rails.start();
