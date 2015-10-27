class Admin::WordsController < ApplicationController
  before_action :require_login, :admin_user
  before_action :load_categories, only: :index

  def index
  end

  def create
    begin
      if object_exist? Category, params[:category_id]
        Word.import params[:file], params[:category_id]
        flash[:success] = t "import_success"
      end
    rescue
      flash[:danger] = t "import_fail"
    end
    redirect_to admin_words_path
  end

  private
  def load_categories
    @categories = Category.all
  end
end
