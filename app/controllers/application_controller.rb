class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  before_filter :header
  skip_before_action :verify_authenticity_token, if: :json_request?
  protect_from_forgery

  def header
  	headers['Access-Control-Allow-Origin'] = '*'
	headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
	headers['Access-Control-Request-Method'] = '*'
	headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
end
