
require 'mocha/api'

module Freightrain

  class AutoStubber
    include Mocha::API

    def stub_viewmodel(name)
      viewmodel_name = "#{name}_view_model"
      viewmodel_class = Object.const_get(viewmodel_name.from_convention)
      viewmodel_class.send(:define_method, :bootstrap) { }
      viewmodel = Freightrain[viewmodel_name.to_sym]
      viewmodel_class.instance_variable_get(:@services).each do |service|
        service_stub = stub_everything
        viewmodel.instance_variable_set("@#{service}", service_stub)
        viewmodel.class.send(:define_method, service) do
          return instance_variable_get("@#{service}")
        end
      end
      viewmodel.instance_variable_set(:@view, stub_everything)
      viewmodel.class.send(:define_method, "view") do
        return instance_variable_get(:@view)
      end
      return viewmodel
    end
    
    def stub_service(name)
      service_name  = "#{name}_service"
      service_class = Object.const_get(service_name.from_convention)
      service       = Freightrain[service_name.to_sym]
      service_class.instance_variable_get(:@services).each do |subservice|
        service_stub = stub_everything
        service.instance_variable_set("@#{subservice}", service_stub)
        service.class.send(:define_method, subservice) do
          return instance_variable_get("@#{subservice}")
        end
      end
      stub_signals = {}
      service_class.instance_variable_get(:@signals).keys.each do |signal_name|
        stub_signals[signal_name] = stub_everything
      end
      service.instance_variable_set(:@signals, stub_signals)
      service_class.send(:define_method, :should_fire) do |signal_name|
        return instance_variable_get(:@signals)[signal_name].expects(:fire)
      end
      return service
    end

    
  end
end