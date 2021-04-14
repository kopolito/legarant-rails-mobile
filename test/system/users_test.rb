require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "Users"
  end

  test "creating a User" do
    visit users_url
    click_on "New User"

    fill_in "Email", with: @user.email
    fill_in "Firstname", with: @user.firstname
    fill_in "Lastname", with: @user.lastname
    fill_in "Mailingcity", with: @user.mailingcity
    fill_in "Mailingcountry", with: @user.mailingcountry
    fill_in "Mailingpostalcode", with: @user.mailingpostalcode
    fill_in "Mailingstate", with: @user.mailingstate
    fill_in "Mailingstreet", with: @user.mailingstreet
    fill_in "Mobilephone", with: @user.mobilephone
    fill_in "Phone", with: @user.phone
    click_on "Create User"

    assert_text "User was successfully created"
    click_on "Back"
  end

  test "updating a User" do
    visit users_url
    click_on "Edit", match: :first

    fill_in "Email", with: @user.email
    fill_in "Firstname", with: @user.firstname
    fill_in "Lastname", with: @user.lastname
    fill_in "Mailingcity", with: @user.mailingcity
    fill_in "Mailingcountry", with: @user.mailingcountry
    fill_in "Mailingpostalcode", with: @user.mailingpostalcode
    fill_in "Mailingstate", with: @user.mailingstate
    fill_in "Mailingstreet", with: @user.mailingstreet
    fill_in "Mobilephone", with: @user.mobilephone
    fill_in "Phone", with: @user.phone
    click_on "Update User"

    assert_text "User was successfully updated"
    click_on "Back"
  end

  test "destroying a User" do
    visit users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User was successfully destroyed"
  end
end
