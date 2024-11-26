require "rails_helper"

# frozen_string_literal: true

RSpec.describe User, type: :model do
  it "名前がなければ無効であること" do
    user = User.new(name: nil)
    expect(user).not_to be_valid
  end
end

