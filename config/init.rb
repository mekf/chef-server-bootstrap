ROOT_DIR = File.expand_path('../../', __FILE__)

Dir[ File.expand_path('../*.rb', __FILE__) ].each do |file|
  require file unless file.include? 'init.rb'
end
