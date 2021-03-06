class ReadLaterEntriesController < ApplicationController
  before_action :logged_in_user

  def create
    user = current_user
    entry = user.read_later_entries.new(entry_params)

    render json: { errors: @comment.errors }, status: :unprocessable_entity unless entry.save
  end

  def index
    user = current_user
    @list = user.read_later_entries.paginate(page: params[:page])
  end

  def destroy
    entry = ReadLaterEntry.find(params[:id])
    entry.destroy if entry.user == current_user
    redirect_to read_later_entries_path
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :date, :description,
                                 :link, :image)
  end
end
