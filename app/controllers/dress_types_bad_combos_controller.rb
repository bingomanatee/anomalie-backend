class DressTypesBadCombosController < ApplicationController
  before_action :set_dress_types_bad_combo, only: [:show, :update, :destroy]

  # GET /dress_types_bad_combos
  def index
    @dress_types_bad_combos = DressTypeBadCombo.all

    render json: @dress_types_bad_combos
  end

  # GET /dress_types_bad_combos/1
  def show
    render json: @dress_types_bad_combo
  end

  # POST /dress_types_bad_combos
  def create
    @dress_types_bad_combo = DressTypeBadCombo.new(dress_types_bad_combo_params)
    if @dress_types_bad_combo.save
      render json: @dress_types_bad_combo, status: :created
    else
      render json: @dress_types_bad_combo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dress_types_bad_combos/1
  def update
    if @dress_types_bad_combo.update(dress_types_bad_combo_params)
      render json: @dress_types_bad_combo
    else
      render json: @dress_types_bad_combo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /dress_types_bad_combos/1
  def destroy
    @dress_types_bad_combo.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dress_types_bad_combo
    @dress_types_bad_combo = DressTypeBadCombo.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def dress_types_bad_combo_params
    params.fetch(:dress_type_bad_combo).permit(:dress_type_id, :combinaion)
  end
end
