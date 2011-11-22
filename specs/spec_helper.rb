#$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../PanoList3')

require 'rubygems'
require 'mac_bacon'

#ENV['DYLD_FRAMEWORK_PATH'] = ENV['BUILT_PRODUCTS_DIR']

Dir.glob('specs/*_spec.rb').each do |test_file|
    print "#{test_file}\n"
    require test_file
end

Bacon.run