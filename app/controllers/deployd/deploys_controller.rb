require_dependency "deployd/application_controller"
require_dependency "deployd/deploy"

module Deployd
  class DeploysController < ApplicationController
    def index
      @deploys = Deployd::Deploy.all
    end
  end
end
