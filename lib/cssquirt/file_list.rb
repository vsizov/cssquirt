require 'rake'
module CSSquirt
  class ImageFileList < Rake::FileList

    # Public: return a CSS document of all images
    #
    # prefix - an optional String to automatically prefix all class names with, useful
    #          for namespacing, etc. Default: nil.
    # header - a optional Boolean value representing whether or not to include the
    #          "generated by" credit in the header of the CSS document. Default: true.
    #
    # Returns a CSS document as a String.
    def to_css(prefix=nil, header=true)
      header_msg = "/* Generated with CSSquirt! (http://github.com/mroth/cssquirt/) */\n"
      header_msg = nil if header == false
      header_msg + self.to_images.map { |img| img.as_css_background_with_class(prefix) }.join("\n")
    end

    # Public: map the filelist to ImageFiles, handling any errors.
    #   For now, this just reports errors to STDERR so they can be noted.
    #
    # Returns an Array of ImageFiles.
    def to_images
      image_map = []
      self.each do |file|
        begin
          image_map << ImageFile.new(file)
        rescue Exception => e
         $stderr.puts "WARNING: skipped file - #{e.message}"
        end
      end
      image_map
    end

  end
end