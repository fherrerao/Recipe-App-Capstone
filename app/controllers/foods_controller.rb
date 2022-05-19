class FoodsController < ApplicationController
  before_action :set_food, only: %i[show edit update update_two destroy]
  load_and_authorize_resource

  # GET /foods or /foods.json
  def index
    @foods = Food.all
  end

  # GET /foods/1 or /foods/1.json
  def show; end

  # GET /foods/new
  def new
    @food = Food.new
  end

  # GET /foods/1/edit
  def edit; end

  # POST /foods or /foods.json
  def create
    @food = Food.new(food_params)
    @food.user = current_user
    respond_to do |format|
      if @food.save
        flash[:success] = 'Food has been created successfully'
        format.html { redirect_to food_url(@food) }
        format.json { render :show, status: :created, location: @food }
      else
        flash[:error] = 'Error: Food could not be created'
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /foods/1 or /foods/1.json
  def update
    respond_to do |format|
      if @food.update(food_params)
        flash[:success] = 'Food has been updated successfully'
        format.html { redirect_to food_url(@food) }
        format.json { render :show, status: :ok, location: @food }
      else
        flash[:error] = 'Error: Food could not be updated'
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_two
    respond_to do |format|
      if @food.update(recipe_food_params)
        flash[:success] = 'Recipe food has been updated successfully'
        format.html { redirect_to recipe_url(params[:recipe]) }
      else
        flash[:error] = 'Error: Recipe food could not be updated'
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foods/1 or /foods/1.json
  def destroy
    @food.destroy

    respond_to do |format|
      flash[:success] = 'Food has been destroyed successfully'
      format.html { redirect_to foods_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_food
    @food = Food.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def food_params
    params.fetch(:food, {}).permit(:name, :measurement_unit, :price)
  end

  def recipe_food_params
    params.require(:food).permit(:quantity, :price)
  end
end
