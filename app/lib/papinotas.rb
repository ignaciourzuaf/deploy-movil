require 'httparty'

# Connector to Papinotas API
# Makes standard requests to the API
class Papinotas
  def initialize
    @base_url = 'https://proyecto.papinotasapi-dev.com/v1'
    @headers_required = ['client', 'uid', 'access-token']

    @headers = { 'Content-Type' => 'application/json;charset=utf-8' }
    @query_params = {}
  end

  # Save login data (already logged)
  def save_login(headers, params)
    save_credentials(headers, params['current_account_id'])
  end

  # Login with email and password
  def login(email, password)
    response = HTTParty.post(@base_url + '/auth/sign_in', body:
      {
        email: email,
        password: password
      })
    save_credentials(response.headers, response['user']['accounts'][0]['id'])
  end

  # Credentials stored
  def credentials
    {
      headers: @headers,
      query_params: @query_params
    }
  end

  # Credentials not nil
  def credentials?
    !(@headers[:'access-token'].nil? ||
      @headers[:client].nil? ||
      @headers[:uid].nil? ||
      @query_params[:current_account_id].nil?)
  end

  # GET /accounts
  def accounts
    body = request_get('accounts')
    body['account']
  end

  # GET /accounts/:id
  def account(account_id)
    body = request_get('accounts', account_id.to_s)
    body['account']
  end

  # get account logged
  def current_account
    account(@current_account_id)
  end

  def children
    body = request_get('universal/accounts/children')
    p "BODYY #{body}"
    body['universal_account'][0]['children']
  end

  # GET /subjects
  def subjects
    body = request_get('subjects')
    body['subject']
  end

  # GET /groups/:id
  def group(id)
    body = request_get('groups', id.to_s)
    body['group']
  end

  # GET /accounts, filter by professors
  def professors
    accounts.select! { |account| account['position']['hierarchy'] == 7 }
  end

  private

  def request_get(*paths)
    url = @base_url + '/' + paths.join('/')
    puts "URL: #{url}"
    puts "PARAMS: #{@query_params}"
    puts "HEADERS: #{@headers}"
    res = HTTParty.get(url, query: @query_params, headers: @headers)
    b = JSON.parse(res.body)
    puts "RES: #{res}"
    puts "BODY: #{b}"
  end

  def save_credentials(headers, current_account_id)
    @headers_required.each do |header|
      @headers[header.to_sym] = headers[header.to_sym] || headers[header.to_s]
    end

    @current_account_id = current_account_id
    @query_params[:current_account_id] = @current_account_id
  end
end
