class TasksController < ApplicationController
  def index
    if params[:sort_expired]
      @tasks = Task.sort_limit
    else
      @tasks = Task.all  
    end
    @tasks = @tasks.name_search(params[:search]) if params[:search].present? 
    @tasks = @tasks.status_search(params[:status]) if params[:status].present? 
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
    params.require(:task).permit(:title, :content, :closing, :status, :priority)
  end
end
