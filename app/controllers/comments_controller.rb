class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @task = Task.find(params[:task_id])
    @comment = @task.comments.build

  end

  def create
    @task = Task.find(params[:task_id])
    @comment = @task.comments.build(comment_params.merge!(user_id: current_user.id))
    if @comment.save!
      redirect_to board_task_path(board_id: @task.board_id, id: @task.id), notice: 'コメントを作成しました'
    else
      flash.now[:error] = '作成できませんでした'
      render :new
    end
  end

  def destroy
    @task = Task.find(params[:task_id])
    @comment = @task.comments.find(params[:id])
    @comment.destroy!
      redirect_to board_task_path(board_id: @task.board_id, id: @task.id), notice: 'コメントを削除しました'
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

end