# Exception Handler for controller actions
module ExceptionHandler
  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches `StandardErrors`
  # class AuthenticationError < StandardError; end

  included do
    # Define custom handlers
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_response
    # rescue_from ExceptionHandler::AuthenticationError,
    #             with: :unauthorized_response

    rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  end

  private

  # JSON response with status 404
  def not_found_response(error)
    json_response(:not_found, detail: error.message)
  end

  # JSON response with status code 422 - unprocessable entity
  def unprocessable_response(error)
    json_response(:unprocessable_entity, detail: error.message)
  end

  # JSON response with status code 401 - Unauthorized
  def unauthorized_response(error)
    json_response(:unauthorized, detail: error.message)
  end
end
