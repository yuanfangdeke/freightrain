
module Gtk

  class Image

    def image=(value)
      file = File.new(File.join(Dir.tmpdir,"tempimg#{self.object_id.to_s}"),'w')
      file << value
      file.close
      self.pixbuf = Gdk::Pixbuf.new(File.join(Dir.tmpdir,"tempimg#{self.object_id.to_s}"))
    end

    def image_file=(file_name)
      self.image=(File.open(file_name).read)
    end
    
  end
end
