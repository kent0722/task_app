class TasksController < ApplicationController
  before_action :set_user
  before_action :set_task, only: [:show, :edit, :destroy]
  before_action :logged_in_user
  before_action :admin_or_correct_user, only: [:update, :destroy]
 
  def index
    @tasks = @user.tasks
  end
  
  def show
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
    @task.destroy
    flash[:success] = "タスクを削除しました。"
    redirect_to user_tasks_url @user
  end
  
  private
  
  def task_params
    params.require(:task).permit(:name, :description)
  end
  
  def set_user
    @user = User.find(params[:user_id])
  end
  
  def set_task
    @task = @user.tasks.find(params[:id])
  end
  
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end
  
  def admin_or_correct_user
     @user = User.find(params[:user_id]) if @user.blank?
     unless current_user?(@user) || current_user.admin?
      flash[:danger] = "権限がありません。"
      redirect_to user_tasks_path(@user)
     end
  end
end
