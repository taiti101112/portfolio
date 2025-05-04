# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '管理者アカウント', type: :request do
  let!(:admin_user) { create(:user, admin: true) }
  let!(:shop) { create(:shop) }

  before do
    sign_in admin_user
  end
end
