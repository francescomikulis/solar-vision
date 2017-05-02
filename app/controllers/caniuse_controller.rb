class CaniuseController < ApplicationController
  def index
    @appliances = Appliance.all
    @panels = Panel.all
    
  end
  
  def new
  end

  def create
  end
end
