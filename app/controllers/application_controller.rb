class ApplicationController < ActionController::API
    before_action :configure_permitted_parameters, if: :devise_controller?
    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: %i[name picture phone street city mean_reviews credit user_id])
    end
end
