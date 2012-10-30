action :enable do
  execute "nxensite #{new_resource.name}" do
    command "/usr/sbin/nxensite #{new_resource.name}"
    not_if do ::File.symlink?("#{node['nginx']['dir']}/sites-enabled/#{new_resource.name}") end
    new_resource.updated_by_last_action(true)
  end
end

action :disable do
  execute "nxdissite #{new_resource.name}" do
    command "/usr/sbin/nxdissite #{new_resource.name}"
    only_if do ::File.symlink?("#{node['nginx']['dir']}/sites-enabled/#{new_resource.name}") end
    new_resource.updated_by_last_action(true)
  end
end

