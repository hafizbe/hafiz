class RecitatorsController < ApplicationController
  before_action :set_recitator, only: [:show, :edit, :update, :destroy]

  # GET /recitators
  # GET /recitators.json
  def index
    @recitators = Recitator.all
  end

  # GET /recitators/1
  # GET /recitators/1.json
  def show
  end

  # GET /recitators/new
  def new
    @recitator = Recitator.new
  end

  # GET /recitators/1/edit
  def edit
  end

  # POST /recitators
  # POST /recitators.json
  def create
    @recitator = Recitator.new(recitator_params)

    respond_to do |format|
      if @recitator.save
        format.html { redirect_to @recitator, notice: 'Recitator was successfully created.' }
        format.json { render action: 'show', status: :created, location: @recitator }
      else
        format.html { render action: 'new' }
        format.json { render json: @recitator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recitators/1
  # PATCH/PUT /recitators/1.json
  def update
    respond_to do |format|
      if @recitator.update(recitator_params)
        format.html { redirect_to @recitator, notice: 'Recitator was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @recitator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recitators/1
  # DELETE /recitators/1.json
  def destroy
    @recitator.destroy
    respond_to do |format|
      format.html { redirect_to recitators_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recitator
      @recitator = Recitator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recitator_params
      params.require(:recitator).permit(:name, :value)
    end
end
