class MachinesController < ApplicationController

  def create
    @machine = Machine.new(machine_params)
    if @machine.save
      redirect_to machines_path
    else
      render show
    end
  end

  def show
    @machines = Machine.all
    @machine = Machine.new
  end

  def update
    @machine = Machine.find(params[:id])
    if @machine.update(machine_params)
      redirect_to machines_path
    else
      render show
    end
  end

private

  def machine_params
    params.require(:machine).permit(:name, :body)
  end

end
