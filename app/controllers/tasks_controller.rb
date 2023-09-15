class TasksController < ApplicationController
  skip_before_action :logged_in, only:[:new]

  def index
    if params[:sort_expired]
      @tasks = Task.sort_limit
    elsif params[:sort_priority]
      @tasks = Task.sort_priority
    else
      @tasks = Task.all  
    end
    @tasks = @tasks.name_search(params[:search]) if params[:search].present? 
    @tasks = @tasks.status_search(params[:status]) if params[:status].present? 

    if params[:user_tasks]
      @tasks = current_user.tasks
    end
    @tasks = @tasks.page(params[:page]).per(3)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      redirect_to @task, notice: "タスクを登録出来ました！"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @task = Task.find(params[:id])
    if @task.user_id != current_user.id
      redirect_to tasks_path, notice: "他人のタスクを見ることはできません！"
    end
  end

  def edit
    @task = Task.find(params[:id])
    if current_user.id != @task.user_id
      redirect_to tasks_path, notice: "他人のタスクは編集できません！"
    end
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
