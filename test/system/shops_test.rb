# frozen_string_literal: true

require 'application_system_test_case'

class ShopsTest < ApplicationSystemTestCase
  setup do
    @shop = shops(:one)
  end

  test 'visiting the index' do
    visit shops_url
    assert_selector 'h1', text: 'Shops'
  end

  test 'should create shop' do
    visit shops_url
    click_on 'New shop'

    fill_in 'Address', with: @shop.address
    fill_in 'Duel space available', with: @shop.duel_space_available
    fill_in 'Name', with: @shop.name
    fill_in 'Opening hours', with: @shop.opening_hours
    fill_in 'Phone number', with: @shop.phone_number
    click_on 'Create Shop'

    assert_text 'Shop was successfully created'
    click_on 'Back'
  end

  test 'should update Shop' do
    visit shop_url(@shop)
    click_on 'Edit this shop', match: :first

    fill_in 'Address', with: @shop.address
    fill_in 'Duel space available', with: @shop.duel_space_available
    fill_in 'Name', with: @shop.name
    fill_in 'Opening hours', with: @shop.opening_hours
    fill_in 'Phone number', with: @shop.phone_number
    click_on 'Update Shop'

    assert_text 'Shop was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Shop' do
    visit shop_url(@shop)
    click_on 'Destroy this shop', match: :first

    assert_text 'Shop was successfully destroyed'
  end
end
