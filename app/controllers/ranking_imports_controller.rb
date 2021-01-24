class RankingImportsController < ApplicationController
  before_action :set_ranking_import, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:edit, :update, :destroy, :new, :create, :import]
  # GET /ranking_imports
  # GET /ranking_imports.json
  def index
    @ranking_imports = RankingImport.all
  end

  # GET /ranking_imports/1
  # GET /ranking_imports/1.json
  def show
    if params[:ranking_category].present? 
      @show_ranking = true
      ranking_year = @ranking_import.rank_date.year 
      @ranking = get_ranking(@ranking_import, params[:ranking_category])
      @ranking = get_gender_and_age(params[:gender], params[:age], @ranking, ranking_year)

      if params[:gender] == "male"
        if params[:age] == "senior"
          @gender = "Herrer"
        else
          @gender = "Gutter"
        end

      end

    if params[:gender] == "female"
      if params[:age] == "senior"
          @gender = "Damer"
        else
          @gender = "Jenter"
        end
    end


      if params[:age] == "senior"
        @age = "Senior"
      elsif params[:age] == "19"
        @age = "U19"
      elsif params[:age] == "16"
        @age = "U16"
      elsif params[:age] == "14"
        @age = "U14"
      end

      if params[:ranking_category] == "single" 
        @ranking_category = "Single"
      else
        @ranking_category = "Double"
      end
          

    else
      @show_ranking = false
      @herrer =  @ranking_import.rankings.where('reliability >= ? AND utr >= ? AND ranking_category = ?', 80, 5.00, "MS" ).limit(10).order('utr desc')
      @damer =  @ranking_import.rankings.where('reliability >= ? AND utr >= ? AND ranking_category = ?', 80, 5.00, "WS" ).limit(10).order('utr desc')
      @senior = Array.new
      @senior << @herrer
      @senior << @damer
    end
  end

  
  
  

  def import
    
    
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

  def get_gender_and_age(gender, age, ranking, ranking_year)
    rank = ranking
    if gender == "male"
      rank = rank.where('ranking_category = ? or ranking_category = ?', "MS", "MD")
    elsif gender == "female"
      rank = rank.where('ranking_category = ? or ranking_category = ?', "WS", "WD")
    end
        
    if age == "19"
      rank = rank.where('birthyear BETWEEN ? AND ?',ranking_year - 19, ranking_year - 17)
    elsif age == "16"
      rank = rank.where('birthyear BETWEEN ? AND ?',ranking_year - 16, ranking_year - 15)
    elsif age == "14"
      rank = rank.where('birthyear BETWEEN ? AND ?',ranking_year - 14, ranking_year - 13 )   
    end 
      rank
  end

  def get_ranking(ranking_import, category)
    if category== "single"
      @ranking_import.rankings.where('reliability >= ? AND utr >= ? AND ranking_category = ? or reliability >= ? AND utr >= ? AND ranking_category = ?', 80, 5.00, "MS", 80, 5.00, "WS" ).order('utr desc')
    elsif category == "double"
      @ranking_import.rankings.where('reliability >= ? AND utr >= ? AND ranking_category = ? or reliability >= ? AND utr >= ? AND ranking_category = ?', 80, 5.00, "MD", 80, 5.00, "WD").order('utr desc')
    end    
  end

  def authenticate_user
      if current_user == nil 
        redirect_to ranking_imports_path
      end
    end

end
