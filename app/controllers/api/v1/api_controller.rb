module Api
  module V1
    class ApiController < ActionController::Base
      before_action :authenticate_user!
      skip_before_action :verify_authenticity_token

    end
  end
end