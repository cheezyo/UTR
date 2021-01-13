require 'test_helper'

class PlayersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player = players(:one)
  end

  test "should get index" do
    get players_url
    assert_response :success
  end

  test "should get new" do
    get new_player_url
    assert_response :success
  end

  test "should create player" do
    assert_difference('Player.count') do
      post players_url, params: { player: { birthdate: @player.birthdate, birthyear: @player.birthyear, member_id: @player.member_id, name: @player.name, profil_link: @player.profil_link, ranking_category: @player.ranking_category, reliability: @player.reliability, utr: @player.utr, utr_player_id: @player.utr_player_id } }
    end

    assert_redirected_to player_url(Player.last)
  end

  test "should show player" do
    get player_url(@player)
    assert_response :success
  end

  test "should get edit" do
    get edit_player_url(@player)
    assert_response :success
  end

  test "should update player" do
    patch player_url(@player), params: { player: { birthdate: @player.birthdate, birthyear: @player.birthyear, member_id: @player.member_id, name: @player.name, profil_link: @player.profil_link, ranking_category: @player.ranking_category, reliability: @player.reliability, utr: @player.utr, utr_player_id: @player.utr_player_id } }
    assert_redirected_to player_url(@player)
  end

  test "should destroy player" do
    assert_difference('Player.count', -1) do
      delete player_url(@player)
    end

    assert_redirected_to players_url
  end
end
