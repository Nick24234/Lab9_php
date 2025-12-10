module Api
  module V1
    class BaseController < ActionController::API
      include Devise::Controllers::Helpers

      before_action :authenticate_user!

      # За потреби тут можна додати спільні для API фільтри/хелпери
    end
  end
end

