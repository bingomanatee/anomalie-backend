class DressesController < ApplicationController
  before_action :set_dress, only: [:show, :update, :destroy]

  # GET /dresses
  def index
    user = user_for_token
    if user.nil?
      render json: {error: 'Not Authorized'}, status: :unprocessable_entity
    else
      @dresses = Dress.where(:user_id => user.id).eager_load(:dress_type, :dress_features, :user)
      render json: @dresses, :include => [:dress_type, :dress_features, :user]
    end
  end

  # GET /dresses/1
  def show
    render json: @dress, :include => :dress_features
  end

  # POST /dresses
  def create
    user = user_for_token
    if user.nil?
      render json: {error: 'Not Authorized'}, status: :unprocessable_entity
    else
      p 'fetching dress_type_id from ', dress_params
      dress_type_id = dress_params["dress_type_id"]
      features = dress_params["features"]

      p '---- finding dress type ', dress_type_id
      dress_type = DressType.find dress_type_id

      if !dress_type
        p '--- cannot find dress type', dress_type_id
        render json: @dress.errors, status: :unprocessable_entity
      else
        @dress = Dress.new()
        @dress.user = user
        @dress.dress_type = dress_type
        @dress.set_features(features)

        if @dress.save
          render json: @dress, status: :created, location: @dress
        else
          render json: @dress.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /dresses/1
  def update
    if @dress.update(dress_params)
      render json: @dress
    else
      render json: @dress.errors, status: :unprocessable_entity
    end
  end

  # DELETE /dresses/1
  def destroy
    user = user_for_token
    if user.nil?
      render json: {error: 'Not Authorized'}, status: :unprocessable_entity
    else
      if !(@dress.user_id == user.id)
        render json: {error: 'Not Authorized'}, status: :unprocessable_entity
      else
        @dress.destroy
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dress
    @dress = Dress.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def dress_params
    params.fetch(:dress, {})
  end

  def configure_permitted_parameters
    attributes = [:name, :id, :image, :features, :dress_type_id]
    devise_parameter_sanitizer.permit(:dress, keys: attributes)
    devise_parameter_sanitizer.permit(:id)
  end
end
