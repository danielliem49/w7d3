class ApplicationController < ActionController::Base

    # need for views
    helper_method :current_user, :logged_in?

    def current_user
        return nil if session[:session_token].nil?
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def require_logged_in
        redirect_to new_session_url unless logged_in?
    end

    def require_logged_out
        redirect_to users_url if logged_in?
    end

    def login!(user)
        session[:session_token] = user.reset_session_token!
    end

    def logged_in?
        if current_user
            return true
        else
            return false
        end
    end

    def logout!
        # reset current_users session token
        current_user.reset_session_token! if logged_in?
        # remove previous session from cookies
        session[:session_token] = nil
        @current_user = nil
    end

end
