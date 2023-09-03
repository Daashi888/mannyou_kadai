class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def create
    @task = Task.new(task_params)
    redirect_to new_task_path
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
  end

  def destroy
  end

  private

  def task_params
    params.require(:blog).permit(:title, :content)
  end
end
