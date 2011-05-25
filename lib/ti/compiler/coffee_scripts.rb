require 'coffee_script'
module Ti
  module Compiler
    class CoffeeScripts
      class << self
        include ::Ti::Utils
        
        def compile_all!
          coffeefile  = File.read(base_location.join('Coffeefile')).split("\n").compact.delete_if { |l| l.include?("#") }
          files       = coffeefile.collect { |a| Dir.glob(coffeefile) }.flatten!
          if files.nil?
            log "There are no files to compile."
            exit(0)
          end
          @contents   = ''
          files.uniq!.each { |f| @contents << File.read(f) }
          compile_location = "Resources/#{underscore(get_app_name).downcase}.js"
          compile(@contents, base_location.join(compile_location))
          log "Your CoffeeScripts have been compiled to: #{compile_location}"
        end
        
        def compile(contents, compile_to_location)
          coffeescript  = ::CoffeeScript.compile(contents, :no_wrap => false)
          File.open(compile_to_location, 'w') { |f| f.write(coffeescript) }
        end
        
      end
    end
  end
end