class HealthcheckController < ApplicationController
  skip_before_action :requires_authentication!, raise: false

  def index
    render json: { status: 'Ok' }, status: :ok
  end
end
