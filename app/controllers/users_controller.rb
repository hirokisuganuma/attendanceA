class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy]
  
  def index
    @users = User.paginate(page: params[:page])
      if current_user.admin?
      else
         redirect_to(root_url) 
         flash[:warning] = "ほかのユーザにはアクセスできません"
      end
      
  end
   
   
  def show
    @user = User.find(params[:id])
    @date = @user.works.where(day: @first_day..@last_day)
  end
   
   
  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)
      if @user.save
        log_in @user
        flash[:success] = "新規登録が完了しました"
        redirect_to user_url(current_user)
      else
        render 'new'      
      end
  end


  def edit
    @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])
      if @user.update_attributes(user_params)
         flash[:success] = "ユーザーのアカウント情報を変更しました"
         redirect_to user_path
      else
         render 'edit'
      end
  end
  
  def csv_output
    date = Work.find_by(date: day,id: user_id)
    
    @works = current_user.works.where(day: date.beginning_of_month..date.end_of_month ).order(:day)
    send_data render_to_string, filename: "#{current_user.name}_#{params[:date].to_time.strftime("%Y年 %m月")}.csv", type: :csv
  end
  
  def base_edit
    @bases = Base.all
    @base = Base.new
  end
  
  def base_add
    @base = Base.new(base_params)
      if @base.save
        flash[:success] = "拠点情報を追加しました。"
        redirect_to base_edit_users_path
      else
        render 'base_edit'
      end
  end
  
  def base_update
    @base = Base.find(params[:id])
      if @base.update(base_params)
        flash[:success] = "拠点情報を更新しました。"
        redirect_to base_edit_users_path
      else
        render 'base_edit'
      end
  end
  
  def base_delete
    @base = Base.find(params[:id])
      if @base.destroy
        flash[:danger] = "拠点情報を削除しました。"
        redirect_to base_edit_users_path
      else
        render 'base_edit'
      end
  end
  
  def base_edit_modal
    @base = Base.find(params[:id])
  end
  
  def edit_basic_info
    @user = User.find(params[:id])
      if current_user.admin?
      else
         redirect_to(root_url) 
         flash[:warning] = "ほかのユーザにはアクセスできません"
      end
  end
  
  
  def update_basic_info
    @user = User.find(params[:id])
      if @user.update_attributes(user_params)
         flash[:success] = "ユーザーの基本情報を更新しました。"
         redirect_to user_path
      else
         render 'edit'
      end
  end

  def working_users
    @users = User.get_working_user.paginate(page: params[:page])
  end
  
  def destroy
    User.fin(params[:id]).destroy
      flash[:success] = "ユーザー登録を削除しました"
        redirect_to users_url
  end
  
   
private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, 
      :affiliation,:start_worktime,:end_worktime,:basic_work_time)
    end
    
    def correct_user
      @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
    def base_params
      params.require(:base).permit(:number, :name, :kind)
    end
end