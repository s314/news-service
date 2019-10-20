class LearningEntriesController < ApplicationController
  def create
    entry = LearningEntry.new(entry_params)
    entry.save
    redirect_to news_path
  end

  def index
    redirect_to(root_url) unless current_user.admin?
    unless params[:category].present?
      @list = LearningEntry.all
    else
      @list = LearningEntry.where(category: params[:category])
    end
  end

  def destroy
    entry = LearningEntry.find(params[:id])
    entry.destroy if current_user.admin?
    redirect_to learning_entries_path
  end

  private

  def entry_params
    params.require(:learning_entry).permit(:title, :description,
                                  :category)
  end
end
