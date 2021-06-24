class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
      flash[:notice] = "コメントを投稿しました"
      redirect_to board_path(comment.board_id)
    else
      flash[:comment] = comment 
      flash[:error_message] = comment.errors.full_messages
      redirect_to board_path(comment.board_id)
    end
  end
  
  def destroy
    comment = Comment.find(params[:id])
    comment.delete

    flash[:notice] = "コメントが削除されました。"
    redirect_to board_path(comment.board_id)
  end

  private
  
  def comment_params
    params.require(:comment).permit(:board_id, :name, :comment)
  end
end
