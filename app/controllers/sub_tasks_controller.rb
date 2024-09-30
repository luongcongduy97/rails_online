# frozen_string_literal: true

class SubTasksController < ApplicationController
  before_action :set_task
  before_action :set_sub_task, only: %i[edit update destroy]

  def new
    @sub_task = @task.sub_tasks.build
  end

  def create
    @sub_task = @task.sub_tasks.build(sub_task_params)

    if @sub_task.save
      respond_to do |format|
        format.html { redirect_to task_path(@task), notice: 'Sub task was successfully created.' }
        format.turbo_stream { flash.now[:notice] = 'Due date was successfully created.' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @sub_task.update(sub_task_params)
      respond_to do |format|
        format.html { redirect_to task_path(@task), notice: 'Sub task was successfully updated.' }
        format.turbo_stream { flash.now[:notice] = 'Due date successfully updated.' }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @sub_task.destroy
    respond_to do |format|
      format.html { redirect_to task_path(@task), notice: 'Sub task was successfully deleted.' }
      format.turbo_stream { flash.now[:notice] = 'Due date was successfully deleted.' }
    end
  end

  private

  def sub_task_params
    params.require(:sub_task).permit(:due_date)
  end

  def set_task
    @task = current_company.tasks.find(params[:task_id])
  end

  def set_sub_task
    @sub_task = @task.sub_tasks.find(params[:id])
  end
end
