require 'csv'

class LearningEntriesController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user,     only: [:index, :destroy, :new]

  def create
    entry = LearningEntry.new(entry_params)
    render json: { errors: @comment.errors }, status: :unprocessable_entity unless entry.save
  end

  def download
    entries = LearningEntry.all

    csv = CSV.generate do |csv|
      entries.each do |row|
        a = row.as_json.map { |k, v| v}
        csv << a
      end
    end

    send_data csv, :type=> 'text/csv'
  end

  def index
    redirect_to(root_url) unless current_user.admin?
    if params[:category].blank?
      @list = LearningEntry.paginate(page: params[:page])
    else
      @list = LearningEntry.where(category: params[:category]).paginate(page: params[:page])
    end
  end

  def destroy
    entry = LearningEntry.find(params[:id])
    entry.destroy if current_user.admin?
    redirect_to learning_entries_path
  end

  def new
    http = Net::HTTP.new("127.0.0.1", "8080")
    request = Net::HTTP::Post.new("http://127.0.0.1:8080/resource/relearn", 'Content-Type' => 'application/json')

    begin
      response = http.request(request)
      flash[:notice] = "Классификатор был успешно переобучен" if response
    rescue
      flash[:alert] = "Произошла ошибка при переобучении классификатора"
    end

    redirect_to learning_entries_path
  end

  private

  def entry_params
    params.require(:learning_entry).permit(:title, :description,
                                  :category)
  end
end
