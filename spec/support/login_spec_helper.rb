# Login Spec Helpers
module LoginSpecHelper
  def papinotas_query_params
    { current_account_id: 1 }
  end

  # Two different types of headers, depending on permission_type (admin, basic)
  def papinotas_headers_basic
    {
      'access-token': 'basic_token',
      client: 'basic_client',
      uid: 'basic_test@papinotas.com'
    }
  end

  def papinotas_headers_admin
    {
      'access-token': 'admin_token',
      client: 'admin_client',
      uid: 'admin_test@papinotas.com'
    }
  end

  # Two different returns for current_account_stub
  def admin_permissions
    {
      id: 1,
      appendable_permissions: [
        { permission_type: 'basic' },
        { permission_type: 'admin' }
      ]
    }
  end

  def basic_permissions
    {
      id: 1,
      appendable_permissions: [
        { permission_type: 'basic' }
      ]
    }
  end

  def current_account_stub(instance)
    return nil unless instance.credentials?
    if instance.credentials[:headers][:client] == 'admin_client'
      admin_permissions
    else
      basic_permissions
    end
  end
end
