service "nginx" do
  action :nothing
end


template "#{node['nginx']['dir']}/sites-available/localhost.conf"
  source "http-proxy.erb"
  owner "root"
  group "root"
  variables({
    :server_name => "example.com",
    :upstream_name => "up-localhost",
    :listen_port => 80,
    :backends => {
      "http://localhost:8080" => nil,
      "http://localhost:8081" => "backup weight=5",
      }
  })
end
