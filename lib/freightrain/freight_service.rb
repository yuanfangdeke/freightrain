# To change this template, choose Tools | Templates
# and open the template in the editor.

module Freightrain

  class FreightService
    extend ContainerHookable

    def self.service(name)
      @@services ||= []
      @@services << (name.to_s + "Service").to_sym
    end

    def initialize
      @@services.each do |service|
        eval "@#{service} = Freightrain[:#{(service.to_s + "Service").to_sym}"
      end
    end

  end
  
end