# Request Spec Helpers
module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end

  def json_message
    json['message']['detail']
  end
end
