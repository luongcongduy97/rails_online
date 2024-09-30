# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = current_company.tasks.order(created_at: :desc)
  end

  def show
    @sub_tasks = @task.sub_tasks
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_company.tasks.build(task_params)

    if @task.save
      respond_to do |format|
        format.html { redirect_to tasks_path }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      respond_to do |format|
        format.html { redirect_to tasks_path, notice: 'Task was successfully destroyed.' }
        format.turbo_stream
      end
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_path }
      format.turbo_stream
    end
  end

  private

  def set_task
    @task = current_company.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :completed, :description)
  end
end
