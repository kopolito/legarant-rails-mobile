class ContractsController < ApplicationController
  before_action :authorize
  before_action :set_contract, only: %i[ show ]

  # GET /contracts or /contracts.json
  def index
    @contracts = Contract.where({accountid: current_user.accountid}).order(:startdate)
  end

  # GET /contracts/1 or /contracts/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contract
      @contract = Contract.find(params[:id])
    end    
end
