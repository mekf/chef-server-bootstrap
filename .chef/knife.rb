require_relative '../config'

cookbook_path    CHEF_CONFIG[:cookbooks_path]
environment_path CHEF_CONFIG[:data_bags_path]
node_path        CHEF_CONFIG[:nodes_path]
role_path        CHEF_CONFIG[:roles_path]
data_bag_path    CHEF_CONFIG[:environments_path]
