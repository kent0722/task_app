class TasksController < ApplicationController
  
  def index
    @user = User.find(params[:user_id])
    @tasks = @user.tasks
  end
  
  def show
    @user = User.find(params[:user_id])
    @task = Task.all
  end
  
  def new
    @user = User.find(params[:user_id])
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    @task.save
    redirect_to user_tasks_url
  end
  
  def edit
    @user = User.find(params[:user_id])
  end
  
  def update
     @task = Task.find(params[:id])
     if @task.update_attributes(task_params)
       flash[:success] = "タスクの情報を更新しました。"
       redirect_to user_tasks_url
     else
       render :edit
     end
  end
  
  def destroy
  end
  
  private
  
  def task_params
    params.require(:taks).permit(:name, :description)
  end
end
