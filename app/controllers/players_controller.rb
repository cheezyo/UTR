class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  # GET /players
  # GET /players.json
  def index
    
    @arr = Array.new
    if params[:type] == "Herrer single"
      @arr << players = Player.where('reliability >= ? AND ranking_category = ? AND utr >= ?', 80, "MS", 5.00).order('utr desc')
      @title = "UTR - " + params[:type] + " uke 1 (01. januar)"
    elsif params[:type] == "Damer single"
      @arr << players = Player.where('reliability >= ? AND ranking_category = ? AND utr >= ?', 80, "WS", 5.00).order('utr desc')
       @title = "UTR - " + params[:type] + " uke 1 (01. januar)"
    elsif params[:type] == "Junior gutter single"
      @arr << u19 = Player.where('reliability >= ? AND ranking_category = ? AND utr >= ?', 80, "MS", 5.00).where('birthyear BETWEEN ? AND ?',2002, 2004).order('utr desc')
      @arr << u16 = Player.where('reliability >= ? AND ranking_category = ? AND utr >= ?', 80, "MS", 5.00).where('birthyear BETWEEN ? AND ?',2005, 2006).order('utr desc')
      @arr << u14 = Player.where('reliability >= ? AND ranking_category = ? AND utr >= ?', 80, "MS", 5.00).where('birthyear BETWEEN ? AND ?',2007, 2008).order('utr desc')
       @title = "UTR - " + params[:type] + " uke 1 (01. januar)"
    elsif params[:type] == "Junior jenter single"
      @arr << u19 = Player.where('reliability >= ? AND ranking_category = ? AND utr >= ?', 80, "WS", 5.00).where('birthyear BETWEEN ? AND ?',2002, 2004).order('utr desc')
      @arr << u16 = Player.where('reliability >= ? AND ranking_category = ? AND utr >= ?', 80, "WS", 5.00).where('birthyear BETWEEN ? AND ?',2005, 2006).order('utr desc')
      @arr << u14 = Player.where('reliability >= ? AND ranking_category = ? AND utr >= ?', 80, "WS", 5.00).where('birthyear BETWEEN ? AND ?',2007, 2008).order('utr desc')
       @title = "UTR - " + params[:type] + " uke 1 (01. januar)"
    else
      @arr << players = Player.all
      @title = ""
    end
      
   
  end

  def herrer_senior
    
  end

  # GET /players/1
  # GET /players/1.json
  def show

  end
  def import
    Player.import(params[:file])
    redirect_to players_url, notice: 'Player was successfully imported.' 

  end
  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url, notice: 'Player was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def player_params
      params.require(:player).permit(:utr_player_id, :name, :birthdate, :birthyear, :member_id, :ranking_category, :utr, :reliability, :profil_link)
    end
end
