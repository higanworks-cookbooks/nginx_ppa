#
# Cookbook Name:: nginx_ppa
# Recipe:: default
#
# Copyright 2012, HiganWorks LLC
#
# All rights reserved
#
#
include_recipe "apt"

apt_repository "nginx-ppa" do
  uri "http://ppa.launchpad.net/nginx/stable/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "C300EE8C"
end 

# cookbook apt has bug ?
# apt-get update notifies does not work.
# here is work around.
execute "apt-get update" do
  command "apt-get update"
  ignore_failure true
  if node['chef_packages']['chef'.]['version'] < 10
    action :run
  else
    action :nothing
  end
end

file "/etc/apt/sources.list.d/nginx-ppa-source.update-once.list" do
  action :create_if_missing
  notifies :run, resources(:execute => "apt-get-update"), :immediately
end

package "nginx" do
  action :install
end

%w(nxensite nxdissite).each do |nxscript|
  template "/usr/sbin/#{nxscript}" do
    source "#{nxscript}.erb"
    mode "0755"
    owner "root"
    group "root"
  end
end

service "nginx" do
  action [:enable, :start]
  supports [:restart, :reload, :status]
end
