class SubTaskItemsController < ApplicationController
  before_action :set_sub_task
  before_action :set_sub_task_item, only: %i[show edit update destroy]

  def index
    @sub_task_items = @sub_task.sub_task_items.order(priority_level: :asc)
  end

  def show; end

  def new
    @sub_task_item = @sub_task.sub_task_items.build
  end

  def create
    @sub_task_item = @sub_task.sub_task_items.build(sub_task_item_params)
    @next_item = @sub_task_item.next_item
    if @sub_task_item.save
      respond_to do |format|
        format.html do
          redirect_to task_path(@sub_task.task), notice: 'Sub task item was successfully created.'
        end
        format.turbo_stream { flash.now[:notice] = 'Sub task item was successfully created.' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @sub_task_item.update(sub_task_item_params)
      redirect_to [@sub_task.task, @sub_task], notice: 'Item was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @sub_task_item.destroy
    redirect_to [@sub_task.task, @sub_task], notice: 'Item was successfully deleted.'
  end

  private

  def set_sub_task
    @sub_task = SubTask.find(params[:sub_task_id])
  end

  def set_sub_task_item
    @sub_task_item = @sub_task.sub_task_items.find(params[:id])
  end

  def sub_task_item_params
    params.require(:sub_task_item).permit(:name, :priority_level)
  end
end
