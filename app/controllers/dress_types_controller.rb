class DressTypesController < ApplicationController
  before_action :set_dress_type, only: [:show, :update, :destroy]

  # GET /dress_types
  def index
    @dress_types = DressType.all.eager_load(:dress_type_features)

    render json: @dress_types
  end

  # GET /dress_types/1
  def show
    render json: @dress_type
  end

  # POST /dress_types
  def create
    @dress_type = DressType.new({:name => dress_type_params["name"]})

    if @dress_type.save
      @dress_type.add_features(dress_type_params["features"])
      render json: @dress_type, status: :created, location: @dress_type
    else
      render json: @dress_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dress_types/1
  def update
    if @dress_type.update(dress_type_params)
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
    # Use callbacks to share common setup or constraints between actions.
    def set_dress_type
      @dress_type = DressType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def dress_type_params
      params.fetch(:dress_type, {})
    end
end
