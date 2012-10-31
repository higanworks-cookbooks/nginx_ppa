service "nginx" do
  action :nothing
end


node['nginx']['proxies'].each_pair do |proxy, options|

  template "#{node['nginx']['dir']}/sites-available/#{proxy}" do
    source "http-proxy.erb"
    owner "root"
    group "root"
    variables({
      :server_name => options["server_name"],
      :document_root => options["document_root"],
      :upstream_name => options["upstream_name"],
      :listen_port => options["listen_port"],
      :backends => options["backends"]
    })
    notifies :reload, "service[nginx]"
  end

  nginx_ppa_site proxy
end if node['nginx']['proxies']
