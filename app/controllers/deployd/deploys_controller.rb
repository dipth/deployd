require_dependency "deployd/application_controller"
require_dependency "deployd/deploy"

module Deployd
  class DeploysController < ApplicationController
    rescue_from UnknownDeployError, :with => :unknown_deploy

    def index
      @deploys = Deployd::Deploy.all
    end

    def show
      @deploy = Deployd::Deploy.new(params[:id])
    end

    def predict
      @pending_pull_request_merges = Deployd::Deploy.pending_pull_request_merges
    end

  protected

    def unknown_deploy
      redirect_to deploys_url, :alert => "Unknown deploy"
    end

  end
end
