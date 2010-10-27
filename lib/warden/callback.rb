Warden::Manager.after_set_user do |record, warden, options|
  scope = options[:scope]
  if !warden.env['HTTP_USER_AGENT'].nil?
    required_string = "#{warden.env['HTTP_USER_AGENT']}-#{warden.request.remote_ip}"
    if warden.session(scope)['user_agent_with_ip'].blank?
      warden.session(scope)['user_agent_with_ip'] = required_string
    elsif required_string != warden.session(scope)['user_agent_with_ip']
      warden.logout(scope)
    end
  end
end