require 'nanoc'

module Nanoc
  module Filters
    class JavascriptConcatenator < Nanoc::Filter

      VERSION = '0.0.2'

      identifier :concat_js

      REQUIRE_RE = /^\s*\/\/\s*=?\s*require\s+(.+?)\s*$/

      # Provides a simple to include other JavaScript files so you can concatenate
      # multiple JavaScript files together.
      #
      # Example:
      #
      #    //= require file-one.js
      #    //= require relative/path/to/file-two.js
      #    //= require /absolute/path/to/file-three.js
      #
      # This method takes no options.
      #
      # @param [String] content The JavaScript
      #
      # @return [String] The resulting JavaScript
      def run(content, args = {})
        current_dir_pathname = Pathname.new(@item[:content_filename]).dirname.realpath
        required_items = []
        content = content.gsub(REQUIRE_RE) do |orig|
          imported_pathname = Pathname.new($1)
          imported_pathname = current_dir_pathname + imported_pathname if imported_pathname.relative?
          if imported_pathname.exist?
            imported_filename = imported_pathname.realpath
            @items.each do |i|
              if !i[:content_filename].nil? &&
                 Pathname.new(i[:content_filename]).realpath == imported_filename
                required_items << i
              end
            end
            "\n;" + File.read(imported_filename)
          else
            orig
          end
        end
        depend_on required_items.uniq if required_items.size > 0
        content
      end

    end
  end
end
