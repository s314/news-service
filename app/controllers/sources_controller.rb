class SourcesController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def index
    @sources = Source.paginate(page: params[:page])
  end

  def new
    @source = Source.new
  end

  def create
    source = Source.new(source_params)
    begin
      rss = RSS::Parser.parse(open(source.address).read, false).items
    rescue
      flash[:alert] = "Некорректный путь к RSS ленте новостей."
      redirect_to new_source_path and return
    end
    flash[:notice] = "Источник был добавлен."
    redirect_to sources_path if source.save
  end

  def destroy
    @source = Source.find(params[:id])
    @source.destroy

    flash[:notice] = "Источник был удален."
    redirect_to sources_path
  end

  def edit
    @source = Source.find(params[:id])
  end

  def update
    @source = Source.find(params[:id])
    @source.update(source_params)

    flash[:notice] = "Источник был изменен."
    redirect_to sources_path
  end

  private

  def source_params
    params.require(:source).permit(:title, :address)
  end
end
