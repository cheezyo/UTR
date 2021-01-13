require "application_system_test_case"

class RankingImportsTest < ApplicationSystemTestCase
  setup do
    @ranking_import = ranking_imports(:one)
  end

  test "visiting the index" do
    visit ranking_imports_url
    assert_selector "h1", text: "Ranking Imports"
  end

  test "creating a Ranking import" do
    visit ranking_imports_url
    click_on "New Ranking Import"

    fill_in "Rank date", with: @ranking_import.rank_date
    fill_in "Title", with: @ranking_import.title
    click_on "Create Ranking import"

    assert_text "Ranking import was successfully created"
    click_on "Back"
  end

  test "updating a Ranking import" do
    visit ranking_imports_url
    click_on "Edit", match: :first

    fill_in "Rank date", with: @ranking_import.rank_date
    fill_in "Title", with: @ranking_import.title
    click_on "Update Ranking import"

    assert_text "Ranking import was successfully updated"
    click_on "Back"
  end

  test "destroying a Ranking import" do
    visit ranking_imports_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ranking import was successfully destroyed"
  end
end
