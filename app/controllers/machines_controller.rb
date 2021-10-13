class MachinesController < ApplicationController

  def create
    @machine = Machine.new(machine_params)
    if @machine.save
      redirect_to machines_path
    else
      render index
    end
  end

  def index
    @machines = Machine.all
    if params[:id]
      @machine = Machine.find(params[:id])
    else
      @machine = Machine.new
    end
  end
  
  def update
    @machine = Machine.find(params[:id])
    if @machine.update(machine_params)
      redirect_to machines_path
    else
      render index
    end
  end

private

  def machine_params
    params.require(:machine).permit(:name, :body)
  end

end
