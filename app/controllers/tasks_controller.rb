class TasksController < ApplicationController
  def index
    @tasks = Task.all  #Taskモデル一覧取得
  end
  
  def show
    @task = Task.find(params[:id])  #id指定で１つだけ取得、@task単数形
  end
  
  def new
    @task = Task.new  #新規作成アクション
  end
  
  def create
    @task = Task.new(task_params)  #new → create処理、Strong Parameter使用
    
    if @task.save
      flash[:success] = "タスクが正常に作成されました"
      redirect_to @task  #tasks/show.html.erb を表示
    else
      flash.now[:danger] = "タスクを作成できませんでした"
      render :new  #tasks/new.html.erb を表示
    end
  end
  
  def edit
    @task = Task.find(params[:id])  #params[:id]で検索
  end
  
  def update  #createとほぼ同じ
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = "タスクが正常に更新されました"
      redirect_to @task  #tasks/show.html.erb を表示
    else
      flash.now[:danger] = "タスクを更新できませんでした"
      render :edit  #tasks/edit.html.erb を表示
    end
  end
  
  def destroy  #削除アクション
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = "タスクは正常に削除されました"
    redirect_to tasks_url  #indexへリダイレクト
  end
  
  
  private
  
  #Strong Parameter
  def task_params
    params.require(:task).permit(:content)
  end

  
end
