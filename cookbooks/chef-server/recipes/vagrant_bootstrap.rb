include_recipe 'chef-server::default'

etc_chef_path = File.join('etc', 'chef-server')
dot_chef_path = File.join('vagrant', '.chef')

files = Dir["#{etc_chef_path}/*.pem"]
puts files

Dir["#{etc_chef_path}/*.pem"].each do |pem_file_path|
  pem_file_name = File.basename(pem_file_path)
  pem_content   = IO.read(pem_file_path)

  file File.join(dot_chef_path, pem_file_name) do
    content pem_content
    sensitive true
  end
end
