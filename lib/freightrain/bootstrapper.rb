
module Freightrain

  attr_accessor :toolkit
  attr_accessor :app_path

  def load_extensions!()
    begin
#      p File.dirname(__FILE__) + "/../extensions/#{@toolkit.to_s}"
      require File.dirname(__FILE__) + "/../extensions/#{@toolkit.to_s}/#{@toolkit.to_s}_bootstrapper.rb"
    rescue Exception => ex
      p "Could not load #{@toolkit}. Have you installed all the required libraries?"
      p "Exception : "
      p ex
    end
  end

  def start(viewmodel_name)
    @toolkit ||= :gtk
    load_extensions!
    auto_require!
    configure_container!
    Freightrain[(viewmodel_name.to_s + "_view_model").to_sym].show
    Toolkit.start_main_loop
  end
  
end
