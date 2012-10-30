actions :enable, :disable

default_action :create

attribute :upstream_name, :name_attribute => true
attribute :backends, :requierd => true, :kind_of => Array
attribute :servername, :kind_of => String, :default => "localhost"
