# Response Helper
module Response
  def json_response(status, params = {})
    json = {
      message: {
        detail: params[:detail] || status.to_s
      },
      status: Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
      # REVIEW: Rack is deprecated?
    }
    json[params[:entity_name]] = params[:object] \
      unless params[:entity_name].nil?
    render json: json, status: status
  end
end
