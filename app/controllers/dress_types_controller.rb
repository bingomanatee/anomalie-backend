class DressTypesController < ApplicationController
  before_action :set_dress_type, only: [:show, :destroy, :update]

  # GET /dress_types
  def index
    @dress_types = DressType.all.eager_load(:dress_type_features, :dress_type_bad_combos)
    render json: @dress_types, :include =>  [:dress_type_features, :dress_type_bad_combos]
  end

  # GET /dress_types/1
  def show
    render json: @dress_type, :include => [:dress_type_features, :dress_type_bad_combos]
  end

  # POST /dress_types
  def create
    @dress_type = DressType.new(dress_attrs)

    if @dress_type.save
      @dress_type.blockers = dress_type_params[:blockers]
      @dress_type.features = dress_type_params[:features]
      render json: @dress_type, status: :created, location: @dress_type
    else
      render json: @dress_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dress_types/1
  def update
    if @dress_type.update(dress_attrs)
      p "dress type updated"
      @dress_type.blockers = dress_type_params[:blockers]
      @dress_type.features = dress_type_params[:features]
      render json: @dress_type
    else
      render json: @dress_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /dress_types/1
  def destroy
    @dress_type.destroy
  end

  private

  def dress_attrs
     {:name => dress_type_params[:name], :image => dress_type_params[:image]}
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_dress_type
    @dress_type = DressType.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def dress_type_params
    params.fetch(:dress_type);
  end

  def configure_permitted_parameters
    attributes = [:name, :id, :image, :features, :blockers]
    devise_parameter_sanitizer.permit(:dress_type, keys: attributes)
    devise_parameter_sanitizer.permit(:id)
  end
end
