class TasksController < ApplicationController
  def index
    if params[:old]
      @tasks = Task.old
    else
      @tasks = Task.all
  end
end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task, notice: "タスクを登録出来ました！"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to @task, notice: "タスクを更新出来ました！"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
      redirect_to tasks_path, notice: "タスクを削除できました！"
  end

  private

  def task_params
    params.require(:task).permit(:title, :content)
  end
end
