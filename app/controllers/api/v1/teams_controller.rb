class Api::V1::TeamsController < ApplicationController
  def index
    render json: Team.all.order(name: :asc)
  end
end
