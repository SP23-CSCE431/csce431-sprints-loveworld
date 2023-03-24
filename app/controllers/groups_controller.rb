class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy]

  # GET /groups or /groups.json
  def index
    @current_id = User.where('email' => current_admin.email).first
    @groups = Group.all
    @user_group_array = Group.select('id').joins(:group_members).where('group_members.user_id' => @current_id.id).to_a.map(&:id)
  end

  # GET /groups/1 or /groups/1.json
  def show
    # on showing group, get user names that belong to that group, and make global variable to be used in html
    @users = User.select('full_name').joins(:group_members).where('group_members.group_id' => params[:id])
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit; end

  # POST /groups or /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to(group_url(@group), notice: 'Group was successfully created.') }
        format.json { render(:show, status: :created, location: @group) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @group.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to(group_url(@group), notice: 'Group was successfully updated.') }
        format.json { render(:show, status: :ok, location: @group) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @group.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group.destroy!

    respond_to do |format|
      format.html { redirect_to(groups_url, notice: 'Group was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:name, :description)
  end
end
