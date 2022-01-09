class Api::V1::TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]

  # GET /todos
  def index
    @todos = Todo.all.order(:created_at)

    render json: @todos,  
        except: [:created_at, :updated_at],
        include: [:tags => {:only => [:id, :name]}]
  end

  # GET /todos/1
  def show
    render json: @todo,
        except: [:created_at, :updated_at],
        include: [:tags => {:only => [:id, :name]}]
  end

  # POST /todos
  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      render json: @todo, except: [:created_at, :updated_at], status: :created
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todos/1
  def update
    if @todo.update(todo_params)
      render json: @todo, except: [:created_at, :updated_at]
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /todos/1
  def destroy
    @todo.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def todo_params
      params.require(:todo).permit(:title, :description, :completion)
    end

    def todo_tag_params
      params.require(:todo).permit(:tags)
    end
end
