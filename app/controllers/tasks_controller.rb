class TasksController < ApplicationController
  def index
    @all_tasks = Task.all
    @all_people = Person.all
  end

  def new
    @task = Task.new #empty task
    @all_people = Person.all
    render :task_editor
  end

  def create
    @task = Task.create(task_create_params[:task]) #task with data
    # if you want a new request, you use redirect
    redirect_to tasks_path
    # if you want to show a view for the current request, use render
    # we need to protect our database from unsanitary people when we use data from other sources

    # @new_task = Task.create(name: params[:task_name], description: params[:task_desc], completed_at: params[:task_completion])
    # @all_tasks = Task.all
    # render :index
  end

  def show
    @shown_task = Task.find(params[:id])
    @task_owner = Person.find(@shown_task.person_id)
    render :show_task
  end

  def edit
    @task = Task.find(params[:id])
    @all_people = Person.all
    render :task_editor
  end

  def update
    @task = Task.find(params[:id])

    if params[:done]
      @task.update(completed_at: Time.now)
    else
      @task.update(task_update_params[:task])
    end

    redirect_to tasks_path
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    redirect_to tasks_path
  end

  # def complete
  #   @task = Task.find(params[:id])
  #   @task.update(completed_at: Time.now)
  #
  #   redirect_to tasks_path
  # end


  private

  def task_create_params
    params.permit(task: [:name, :description, :completed_at, :person_id])
  end

  def task_update_params
    params.permit(task: [:name, :description, :completed_at, :person_id])
  end

  # do I need one for delete? I'm deleting the whole task, no chance to touch individual params I think
end
