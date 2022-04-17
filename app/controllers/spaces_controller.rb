# frozen_string_literal: true

# Exposes CRUD actions for {Space} Resources.
class SpacesController < ApplicationController
  def show; end

  def edit; end

  def update
    if space.update(space_params)
      flash[:notice] = t('.success')
      redirect_to space_path(space)
    else
      flash[:alert] = t('.error')
      render :edit
    end
  end

  def create
    skip_policy_scope
    client = Client.find_or_create_by(name: space_params[:name])
    authorize(client)
    @space = Space.new(space_params.merge(client: client))
    authorize(@space)
    if @space.save
      render json: Space::Serializer.new(@space).to_json
    else
      render json: Space::Serializer.new(@space).to_json, status: :unprocessable_entity
    end
  end

  def destroy
    space.destroy
  end

  def space_params
    @space_params ||= policy(Space).permit(params)
  end

  helper_method def space
    @space ||= current_space.tap do |space|
      authorize(space)
    end
  end
end
