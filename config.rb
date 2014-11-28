ROOT_DIR = File.dirname(__FILE__)

CHEF_CONFIG = {
  cookbooks_path:    File.join(ROOT_DIR, 'cookbooks'),
  data_bags_path:    File.join(ROOT_DIR, 'data_bags'),
  nodes_path:        File.join(ROOT_DIR, 'nodes'),
  roles_path:        File.join(ROOT_DIR, 'roles'),
  environments_path: File.join(ROOT_DIR, 'environments')
}
