#
#  run_tests.rb
#  PanoList3
#
#  Created by Matthieu DESILE on 11/22/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#
require 'rubygems'
require 'mac_bacon'

ENV['DYLD_FRAMEWORK_PATH'] = ENV['BUILT_PRODUCTS_DIR']

#Dir.chdir "PanoList3"

Dir.glob('./PanoList3/*_spec.rb').each do |test_file|
    require test_file
end

Bacon.run