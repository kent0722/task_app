class TasksController < ApplicationController
  before_action :set_task, only: [:index, :show, :new, :create, :edit, :update]
  before_action :logged_in_user
  before_action :correct_user
 
  def index
    @tasks = @user.tasks
  end
  
  def show
    @task = @user.tasks.find(params[:id])
  end
  
  def new
    @task = Task.new
  end
    
  def create
     @task = @user.tasks.build(task_params)
    if @task.save
      flash[:success] = "タスクが作成されました" 
      redirect_to user_tasks_url(@user) 
    else
      render :new
    end
  end
  
  def edit
    @task = @user.tasks.find(params[:id])
  end
  
  def update
    @task = @user.tasks.find_by(id: params[:id])
    if @task.update(task_params)
      flash[:success] = "タスクの情報を更新しました。"
      redirect_to user_tasks_url(@user)
    else
      render :edit
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = "タスクが削除されました"
    redirect_to user_tasks_url
  end
  
  private
  
  def task_params
    params.require(:task).permit(:name, :description)
  end
  
  def set_task
    @user = User.find(params[:user_id])
  end
  
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end
  
  def correct_user
    redirect_to(root_url) unless @user == current_user
  end
end
