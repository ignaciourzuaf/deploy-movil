# Handler to Papinotas connector
module PapinotasHandler
  def build_connector(headers, params)
    @connector = Papinotas.new
    @connector.save_login(headers, params)
  end

  def current_account
    @connector.current_account
  end

  def papinotas_subjects
    @connector.subjects
  end

  def admin?(current_account)
    permissions = current_account['appendable_permissions'] ||
                  current_account[:appendable_permissions]
    in_hash_array?(permissions, 'permission_type', 'admin')
  end

  def account_children
    @connector.children
  end
end

def in_hash_array?(array, key, value)
  return nil if array.nil? || key.nil? || value.nil?
  selected = array.select do |item|
    item[key.to_s] == value || item[key.to_sym] == value
  end
  !selected.empty?
end
