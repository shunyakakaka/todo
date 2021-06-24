class BoardsController < ApplicationController

  before_action :set_target_before, only: [:show, :edit, :update, :destroy]
  def index
    @boards = Board.page(params[:page])
  end

  def new
    @board = Board.new(flash[:board])
  end

  def create
    board = Board.new(board_params)
    if board.save
      flash[:notice] = "「#{board.title}」の掲示板を作成しました。"
      redirect_to board_path(board.id)
    else
      redirect_to new_board_path, flash: {board: board,
        error_message: board.errors.full_messages
      }
    end
    binding.pry
  end

  def show
    @comment = Comment.new(board_id: @board.id)
  end

  def edit
  end

  def update
    @board.update(board_params)
    if @board.save
      flash[:notice] = "編集しました"
      redirect_to board_path(@board.id)
    else
      redirect_to edit_board_path, flash: {board: @board,
        error_message: @board.errors.full_messages
      }
    end
  end

  def destroy
    @board.destroy
    flash[:notice] = "「#{@board.title}」を削除しました。"
    redirect_to boards_path
  end

  private
  def board_params
    params.require(:board).permit(:name, :title, :body, tag_ids: [] )
  end
  
  def set_target_before
    @board = Board.find(params[:id])
  end

end
