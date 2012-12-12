class UsersController < ApplicationController
  # GET /sites
  # GET /sites.json
  before_filter :authenticate_user! 
  before_filter :validate_admin
  before_filter :find_user, :only => [:show, :edit, :update, :destroy]
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sites }
    end
  end

  # GET /sites/1
  # GET /sites/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /sites/new
  # GET /sites/new.json
  def new
    @site = Site.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @site }
    end
  end

  # GET /sites/1/edit
  def edit
  end

  # PUT /sites/1
  # PUT /sites/1.json
  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    #@user.approved =  params[:user][:approved] == '1'
    #@user.admin =  params[:user][:admin] == '1'

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'Site was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  # Helper method to restrict non-admin users
  protected
    def validate_admin
      if not current_user.admin?
        render :status => :forbidden, :text => 'You are not authorized to access this area.'
      end
    end
  protected
    def find_user
      @user = User.find(params[:id])
    end
end
