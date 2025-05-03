require 'rails_helper'

RSpec.describe 'Admin::Shops API', type: :request do
  let!(:admin_user) { create(:user, admin: true) }
  let!(:shop) { create(:shop) }

  before do
    sign_in admin_user
  end

end
