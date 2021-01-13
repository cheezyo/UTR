class RankingImportsController < ApplicationController
  before_action :set_ranking_import, only: [:show, :edit, :update, :destroy]

  # GET /ranking_imports
  # GET /ranking_imports.json
  def index
    @ranking_imports = RankingImport.all
  end

  # GET /ranking_imports/1
  # GET /ranking_imports/1.json
  def show
      @arr = Array.new
      rank = @ranking_import.rankings.where('reliability >= ? AND utr >= ?', 80, 5.00)
      damer = rank.where('ranking_category = ?',  "WS").order('utr desc')
      herrer = rank.where('ranking_category = ?',  "MS").order('utr desc')

    if params[:type] == "Herrer single"
      @arr << herrer
    
    elsif params[:type] == "Damer single"
      @arr << damer

    elsif params[:type] == "Junior gutter single"
      @arr << u19 = herrer.where('birthyear BETWEEN ? AND ?',2002, 2004).order('utr desc')
      @arr << u16 = herrer.where('birthyear BETWEEN ? AND ?',2005, 2006).order('utr desc')
      @arr << u14 = herrer.where('birthyear BETWEEN ? AND ?',2007, 2008).order('utr desc')

    elsif params[:type] == "Junior jenter single"
      @arr << u19 = damer.where('birthyear BETWEEN ? AND ?',2002, 2004).order('utr desc')
      @arr << u16 = damer.where('birthyear BETWEEN ? AND ?',2005, 2006).order('utr desc')
      @arr << u14 = damer.where('birthyear BETWEEN ? AND ?',2007, 2008).order('utr desc')

    else
      @arr << players = rank.where('utr >= ?', 5.00).order('utr desc')
      @title = ""
    end
      
  end

  

  def import
    logger.debug "*************" + params[:ranking_import_id]
    
    RankingImport.import(params[:file], params[:ranking_import_id])
    redirect_to ranking_imports_url, notice: 'Ranking was successfully imported.' 
  end

  # GET /ranking_imports/new
  def new
    @ranking_import = RankingImport.new
  end

  # GET /ranking_imports/1/edit
  def edit
  end

  # POST /ranking_imports
  # POST /ranking_imports.json
  def create
    @ranking_import = RankingImport.new(ranking_import_params)

    respond_to do |format|
      if @ranking_import.save
        format.html { redirect_to @ranking_import, notice: 'Ranking import was successfully created.' }
        format.json { render :show, status: :created, location: @ranking_import }
      else
        format.html { render :new }
        format.json { render json: @ranking_import.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ranking_imports/1
  # PATCH/PUT /ranking_imports/1.json
  def update
    respond_to do |format|
      if @ranking_import.update(ranking_import_params)
        format.html { redirect_to @ranking_import, notice: 'Ranking import was successfully updated.' }
        format.json { render :show, status: :ok, location: @ranking_import }
      else
        format.html { render :edit }
        format.json { render json: @ranking_import.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ranking_imports/1
  # DELETE /ranking_imports/1.json
  def destroy
    @ranking_import.destroy
    respond_to do |format|
      format.html { redirect_to ranking_imports_url, notice: 'Ranking import was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ranking_import
      @ranking_import = RankingImport.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ranking_import_params
      params.require(:ranking_import).permit(:rank_date, :title)
    end
end
