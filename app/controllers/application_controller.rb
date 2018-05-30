# Application controller
class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  include PapinotasHandler

  before_action :connect_papinotas
  before_action :require_account

  def respond_error(status, detail = nil)
    json_response(
      status,
      detail: detail,
      entity_name: controller_name.classify.downcase
    )
  end

  def connect_papinotas
    build_connector(request.headers, params)
    @current_account = current_account
  end

  def require_account
    respond_error(:unauthorized, 'Login incorrecto') if @current_account.nil?
  end

  def require_admin
    respond_error(:unauthorized, 'Necesitas ser admin') \
      unless admin?(@current_account)
  end
end
