#$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../PanoList3')

require 'rubygems'
require 'fakefs/spec_helpers'
require 'mac_bacon'

ENV['DYLD_FRAMEWORK_PATH'] = ENV['BUILT_PRODUCTS_DIR']

module FakeFS
    def self.read_filesystem filename
        file = RealFile.new filename, 'r'
        while line = file.gets
            line.chomp!
            if line =~ /\/$/ then
                FileUtils.mkdir_p line
            else
                FileUtils.touch line
            end
    end
        file.close
    end
end

Dir.glob('specs/*_spec.rb').each do |test_file|
    print "#{test_file}\n"
    require test_file
end

Bacon.run
