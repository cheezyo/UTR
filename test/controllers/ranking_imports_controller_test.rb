require 'test_helper'

class RankingImportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ranking_import = ranking_imports(:one)
  end

  test "should get index" do
    get ranking_imports_url
    assert_response :success
  end

  test "should get new" do
    get new_ranking_import_url
    assert_response :success
  end

  test "should create ranking_import" do
    assert_difference('RankingImport.count') do
      post ranking_imports_url, params: { ranking_import: { rank_date: @ranking_import.rank_date, title: @ranking_import.title } }
    end

    assert_redirected_to ranking_import_url(RankingImport.last)
  end

  test "should show ranking_import" do
    get ranking_import_url(@ranking_import)
    assert_response :success
  end

  test "should get edit" do
    get edit_ranking_import_url(@ranking_import)
    assert_response :success
  end

  test "should update ranking_import" do
    patch ranking_import_url(@ranking_import), params: { ranking_import: { rank_date: @ranking_import.rank_date, title: @ranking_import.title } }
    assert_redirected_to ranking_import_url(@ranking_import)
  end

  test "should destroy ranking_import" do
    assert_difference('RankingImport.count', -1) do
      delete ranking_import_url(@ranking_import)
    end

    assert_redirected_to ranking_imports_url
  end
end
