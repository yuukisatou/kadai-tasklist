class TasksController < ApplicationController
  
  #before action で省略と共通化
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in, except: :index
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    if logged_in?
      @user = current_user
      @task = current_user.tasks.build #form_for用
      @tasks = current_user.tasks.all.page(params[:page])
    end
  end
  
  def show
  end
  
  def new
    @task = Task.new  #新規作成アクション
  end
  
  def create
    @task = current_user.tasks.build(task_params)  #new → create処理、Strong Parameter使用
    
    if @task.save
      flash[:success] = "タスクが正常に作成されました"
      redirect_to @task  #tasks/show.html.erb を表示
    else
      flash.now[:danger] = "タスクを作成できませんでした"
      render :new  #tasks/new.html.erb を表示
    end
  end
  
  def edit
  end
  
  def update  #createとほぼ同じ
    if @task.update(task_params)
      flash[:success] = "タスクが正常に更新されました"
      redirect_to @task  #tasks/show.html.erb を表示
    else
      flash.now[:danger] = "タスクを更新できませんでした"
      render :edit  #tasks/edit.html.erb を表示
    end
  end
  
  def destroy  #削除アクション
    @task.destroy
    
    flash[:success] = "タスクは正常に削除されました"
    redirect_to tasks_url  #indexへリダイレクト
  end
  
  
  private
  
  def set_task    #id検索を共通化
    @task = Task.find(params[:id])
  end

  def task_params   #Strong Parameter
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end

  
end
