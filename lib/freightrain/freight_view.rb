require File.dirname(__FILE__) + "/gtk_builder_helper.rb"

module Freightrain
  

  class FreightView
    include GtkBuilderHelper
    include DialogHelper
    extend ContainerHookable
    
    attr_reader :signals

    def toplevel
      return @builder.objects.select { |widget| widget.kind_of? Gtk::Window}[0]
    end
    
    def self.signal(signal_name)
      @signals ||= []
      @signals << signal_name.to_sym
    end

    def fire(signal, *args)
      @signals[signal.to_sym].fire(*args)
    end

    def initialize
      load_from_file(File.join(Freightrain.APP_PATH,"views","#{self.class.name}.glade"))
      @signals = {}
      signals = self.class.instance_variable_get(:@signals)
      signals ||= []
      signals.each do |signal|
        @signals[signal] = FreightSignal.new
      end

    end

  end

end
